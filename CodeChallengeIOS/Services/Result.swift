//
//  Result.swift
//  MVVMRoot
//
//  Created by Apple on 8/23/18.
//  Copyright © 2018 Lê Hùng. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


enum SingleResult<C: BaseModel> {
    case success(C)
    case failure(message: String)
    
    static func handleResponse(_ response: AFDataResponse<Any>) -> SingleResult {
        switch response.result {
            
        case .success(let value):
            let json = JSON(value)
            let error = C(json: json)
            let result = C(json: json["articles"])!
            
            if error?.ResultCode == .Success {
                return SingleResult.success(result)
            }
            return SingleResult.failure(message: error?.MessageInfo ?? "")
        case .failure(let error):
            return SingleResult.failure(message: error.localizedDescription)
        }
    }
}

enum ListResult<C: BaseModel> {
    case success([C])
    case failure(message: String)

    static func handleResponse(_ response: AFDataResponse<Any>) -> ListResult {
        switch response.result{
            
        case .success(let value):
            let json = JSON(value)
            
            let error = C(json: json)
            var result = [C]()
            if let items = json["articles"].array {
                for data in items {
                    result.append(C(json: data)!)
                }
            }

            if error?.ResultCode == .Error {
                return ListResult.failure(message: error!.MessageInfo)
            }

            return ListResult.success(result)
        case .failure(let error):
            return ListResult.failure(message: error.localizedDescription)
        }

        

    }
}

enum OneResult<C: BaseModel> {
    case success(Int)
    case failure(message: String)
    static func handleResponse(_ response: AFDataResponse<Any>) -> OneResult {
        
        switch response.result {
            
        case .success(let value):
            let json = JSON(value)
            let error = C(json: json)
            let result = json["result"].intValue

            if error?.ResultCode == .Error {
                return OneResult.failure(message: error?.MessageInfo ?? "")
            }

            return OneResult.success(result)
        case .failure(let error):
            return OneResult.failure(message: error.localizedDescription)
        }

        
    }
}

enum OneBoolResult<C: BaseModel> {
    case success(Bool)
    case failure(message: String)
    static func handleResponse(_ response: AFDataResponse<Any>) -> OneBoolResult {
        switch response.result {
            
        case .success(let value):
            let json = JSON(value)
            let error = C(json: json)
            let result = json["result"].boolValue

            if error?.ResultCode == .Error {
                return OneBoolResult.failure(message: error?.MessageInfo ?? "")
            }

            return OneBoolResult.success(result)
        case .failure(let error):
            return OneBoolResult.failure(message: error.localizedDescription)
        }

        
    }
}

enum OneResultString<C: BaseModel> {
    case success(String)
    case failure(message: String)
    static func handleResponse(_ response: AFDataResponse<Any>) -> OneResultString {
        switch response.result{
            
        case .success(let value):
            let json = JSON(value)
            let error = C(json: json)
            let result = json["result"].stringValue

            if error?.ResultCode == .Error {
                return OneResultString.failure(message: error?.MessageInfo ?? "")
            }

            return OneResultString.success(result)
        case .failure(let error):
            return OneResultString.failure(message: error.localizedDescription)
        }

        
    }
}
