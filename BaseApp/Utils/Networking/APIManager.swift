//
//  APIManager.swift
//  BaseApp
//
//  Created by Lee on 2019/6/28.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import Moya

enum APIManager {
    case login(param: [String: Any])
    case register(param: [String: Any]?)
    case getSomeString
    case postImage(param: [URL])
    case getTodayHistory(param: [String: Any])
}

extension APIManager: TargetType {
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json; charset=utf-8"]
    }
    
    
    var baseURL: URL {
        return URL(string: BaseUrl)!
    }
    
    var path: String {
        switch self {
        case .login(_):
            return "/login"
        case .register(_):
            return "/register"
        case .getSomeString:
            return "/getSomeString"
        case .postImage(_):
            return "/postImage"
        case .getTodayHistory:
            return "/japi/toh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login(_), .register(_):
            return .post
        case .getSomeString:
            return .get
        case .postImage(_):
            return .post
        case .getTodayHistory:
            return .post
        }
    }
    
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let param):
            return param
        case .register(let param):
            return param
        case .getSomeString:
            return nil
        case .postImage(_):
            return [:]
        case .getTodayHistory(let param):
            return param
        }
    }
    
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .login(_):
            return URLEncoding.queryString
        case .register(_):
            return URLEncoding.queryString
        case .getSomeString:
            return URLEncoding.queryString
        case .postImage(_):
            return URLEncoding.queryString
        case .getTodayHistory(let param):
            return URLEncoding.queryString
        }
    }
    
    //UITest
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestParameters(parameters: param, encoding: parameterEncoding)
        case .register(let param):
            return .requestParameters(parameters: param ?? [:], encoding: parameterEncoding)
        case .getSomeString:
            return .requestParameters(parameters: [:], encoding: parameterEncoding)
        case .postImage(let param):
            var formDataAry: [Any] = Array()
            for (index, url) in param.enumerated() {
                let data = try! Data.init(contentsOf: url)
                let image = UIImage.init(data: data)?.compressed()
                let compressedJpegData = image?.jpegData(compressionQuality: 0.01)
                let compressedPngData = image?.pngData()
                let imageData = image?.pngData() == nil ? compressedJpegData : compressedPngData
                //根据当前时间设置图片上传时候的名字
                let date:Date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
                var dateStr:String = formatter.string(from: date as Date)
                //别忘记这里给名字加上图片的后缀哦
                dateStr = dateStr.appendingFormat("-%i.png", index)
                let formData = MultipartFormData(provider: .data(imageData ?? Data()), name: "files", fileName: dateStr, mimeType: "image/jpeg")
                formDataAry.append(formData)
            }
            return .uploadCompositeMultipart(formDataAry as! [MultipartFormData], urlParameters: [:])
        case .getTodayHistory(let param):
            return .requestParameters(parameters: param, encoding: parameterEncoding)
        }
    }
    
    
    
    
}
