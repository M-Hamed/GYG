//
//  HURLRequestConvertible.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import Alamofire

protocol HURLRequestConvertible: URLRequestConvertible {
    var baseUrl:    String?             { get }
    var method:     HTTPMethod          { get }
    var name:       String              { get }
    var path:       String              { get }
    var parameters: Parameters?         { get }
}

extension HURLRequestConvertible {
    
    //Can be overriden
    var baseUrl: String? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try (baseUrl ?? Constants.baseApiURL).asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        if let params = parameters {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        return urlRequest
    }
    
}
