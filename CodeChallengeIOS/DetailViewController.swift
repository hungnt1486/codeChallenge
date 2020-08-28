//
//  DetailViewController.swift
//  CodeChallengeIOS
//
//  Created by Lê Hùng on 8/28/20.
//  Copyright © 2020 hungle. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var tbvDetail: UITableView!
    var detailModel: NewsModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
    }
    
    func setupTableView(){
        self.navigationItem.title = "News Detail"
        self.tbvDetail.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")

        self.tbvDetail.delegate = self
        self.tbvDetail.dataSource = self
        self.tbvDetail.separatorColor = UIColor.clear
        self.tbvDetail.separatorInset = UIEdgeInsets.zero
        self.tbvDetail.estimatedRowHeight = 100
        self.tbvDetail.rowHeight = UITableView.automaticDimension
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        
        cell.lbTitle.text = detailModel?.title
        cell.lbSubTitle.text = detailModel?.description
        cell.lbTime.text = detailModel?.publishedAt
        let str = detailModel?.urlToImage?.replacingOccurrences(of: " ", with: "%20")
        
        cell.imgAvatar.sd_setImage(with: URL.init(string: str ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        return cell
    }
    
    
}
