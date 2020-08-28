//
//  MainViewController.swift
//  CodeChallengeIOS
//
//  Created by Lê Hùng on 8/27/20.
//  Copyright © 2020 hungle. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class MainViewController: BaseViewController {

    @IBOutlet weak var tbvMain: UITableView!
    var listNews: [NewsModel] = []
    
    lazy var refreshControl: UIRefreshControl = {
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action:
               #selector(self.handleRefresh(_:)),
                                    for: UIControl.Event.valueChanged)
           refreshControl.tintColor = UIColor.gray
           
           return refreshControl
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.showProgressHub()
        self.getListNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "News"
        
    }
    
    func loadFileJson(name: String) -> JSON{
        var json: JSON?
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let textFileURL = documentsPath.appendingPathComponent("news.json")
        let fileURLString = textFileURL?.path
        if FileManager.default.fileExists(atPath: (fileURLString)!){
            print("success")
        }
        do {
            let data = try Data(contentsOf: textFileURL!, options: [])
            json = try JSON.init(data: data, options: .fragmentsAllowed)
        } catch let error {
            print(error.localizedDescription)
        }
        
        
//        print(json)
        return json ?? JSON()
    }
    
    func setupTableView(){
        self.tbvMain.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")

        self.tbvMain.delegate = self
        self.tbvMain.dataSource = self
        self.tbvMain.estimatedRowHeight = 100
        self.tbvMain.rowHeight = UITableView.automaticDimension
        self.tbvMain.addSubview(refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.getListNews()
        refreshControl.endRefreshing()
    }
    
    
    func saveDataToFile(listNews: [NewsModel]){
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!

        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("news.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = true

        // creating a .json file in the Documents folder
        if !fileManager.fileExists(atPath: jsonFilePath?.absoluteString ?? "", isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: jsonFilePath?.absoluteString ?? "", contents: nil, attributes: nil)
            if created {
                print("File created ")
            } else {
                print("Couldn't create file for some reason")
            }
        } else {
            print("File already exists")
        }
        
        var strJson = [[String: String?]]()
        
        for item in self.listNews {
           let dict =  [
                "author": item.author,
                "title": item.title,
                "description": item.description,
                "url": item.url,
                "urlToImage": item.urlToImage,
                "publishedAt": item.publishedAt,
                "content": item.content
            ]
            strJson.append(dict)
        }

        // creating JSON out of the above array
        var jsonData: NSData!
        do {
            jsonData = try JSONSerialization.data(withJSONObject: strJson, options: JSONSerialization.WritingOptions()) as NSData

        } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }

        // Write that JSON to the file created earlier
        do {
            let file = try FileHandle(forWritingTo: jsonFilePath!)
            file.write(jsonData as Data)
//            print("JSON data was written to teh file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
    }
    
    func getListNews(){
        MainManager.shareMainManager().getListNews {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                
                self.listNews.removeAll()
                self.listNews = [NewsModel]()
                
                for model in data {
                    self.listNews.append(model)
                }
                self.saveDataToFile(listNews: self.listNews)
                
                self.tbvMain.reloadData()
                break
            case .failure(message: let message):
                print(message)
                self.hideProgressHub()
                if message == "URLSessionTask failed with error: The Internet connection appears to be offline." {
                    let json = self.loadFileJson(name: "news")
                    let data = NewsArrModel.init(json: json)
                    self.listNews = data!.NewsArr!
                    self.tbvMain.reloadData()
                }
                break
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        let model = listNews[indexPath.row]
        cell.lbTitle.text = model.title
        cell.lbSubTitle.text = model.description
        cell.lbTime.text = model.publishedAt
        let str = model.urlToImage?.replacingOccurrences(of: " ", with: "%20")
        cell.imgAvatar.sd_setImage(with: URL.init(string: str ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listNews[indexPath.row]
        let detail = DetailViewController()
        detail.detailModel = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
