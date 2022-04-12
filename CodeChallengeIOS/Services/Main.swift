//
//  Main.swift
//  CodeChallengeIOS
//
//  Created by Lê Hùng on 8/28/20.
//  Copyright © 2020 hungle. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MainManager{
    
    class func shareMainManager() -> MainManager {
        struct Static {static let _shareMainManager = MainManager()}
        return Static._shareMainManager
    }
    
    func getListNews(completion: @escaping(ListResult<NewsModel>) -> Void){
        AF.request(URLs.getNews, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            print("getListNews = \(response)")
            completion(ListResult<NewsModel>.handleResponse(response))
        }
    }

}
