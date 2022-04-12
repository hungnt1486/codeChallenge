//
//  BaseViewController.swift
//  cityBus
//
//  Created by Lê Hùng on 5/31/19.
//  Copyright © 2019 Lê Hùng. All rights reserved.
//

import UIKit

import UIKit
import Alamofire
import MBProgressHUD

class BaseViewController: UIViewController {
    
    
    let delegateApp = UIApplication.shared.delegate as! AppDelegate
    
    public static var accessToken = String()
    
    public static var deviceToken = String()
    
    
    public static var headers: HTTPHeaders = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        // Do any additional setup after loading the view.
        configToken()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "ic_bg_nav"), for: .default)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configToken() {
        BaseViewController.headers = ["X-Auth-Token": BaseViewController.accessToken, "Accept": "application/json"]
//        BaseViewController.deviceToken = "gewgewg"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProgressHub() -> Void {
        let window = delegateApp.window
        MBProgressHUD.showAdded(to: window!, animated: true)
    }
    
    func hideProgressHub() -> Void {
        let window = delegateApp.window
        MBProgressHUD.hide(for: window!, animated: true)
    }
    
    
}
