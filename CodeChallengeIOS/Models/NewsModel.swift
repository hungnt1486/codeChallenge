//
//  NewsModel.swift
//  CodeChallengeIOS
//
//  Created by Lê Hùng on 8/28/20.
//  Copyright © 2020 hungle. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsModel: BaseModel {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    required init?(json: JSON) {
        super.init(json: json)
        author = json["author"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        url = json["url"].stringValue
        urlToImage = json["urlToImage"].stringValue
        publishedAt = json["publishedAt"].stringValue
        content = json["content"].stringValue
    }
}

class NewsArrModel: BaseModel{
    
    var NewsArr: [NewsModel]?
    required init?(json: JSON) {
        super.init(json: json)
        guard json.error == nil else {
            return
        }
        if let listNews = json.array {
            NewsArr = [NewsModel]()
            for item in listNews {
                NewsArr?.append(NewsModel(json: item)!)
            }
        }
    }
    
}
