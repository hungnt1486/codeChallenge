//
//  URLs.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//
import UIKit

struct URLs {
    
    static func getDate() -> String{
        var strCurrentDate: String
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = Date.init()
        strCurrentDate = formatter.string(from: date)
        return strCurrentDate
    }
    // for test
    static let linkServer = "http://newsapi.org/v2/everything?q=bitcoin&from="//2020-07-28"
    
    static var getNews: String{
        return String(format: "%@%@&sortBy=publishedAt&apiKey=7e968e78523641e0acd86c84af4cb6f2", linkServer, getDate())
    }
}
