//
//  Constants.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import Foundation
enum Environment {
    case debug
    case release
    
    static var current: Environment {
        return .debug 
    }
}

struct Constants {
    private init() {}
    
    static let environment = Environment.current
    
    static var baseURL: String {
        switch environment {
        case .debug:
            return "https://www.getyourguide.com"
        case .release:
            return "https://www.getyourguide.com"
        }
    }
    
    static var baseApiURL: String {
        switch environment {
        case .debug:
            return baseURL + "/\(namespace)/\(APIVersion.v1.rawValue)"
        case .release:
            return baseURL + "/\(namespace)/\(APIVersion.v1.rawValue)"
        }
    }
    
}

extension Constants {
    static var namespace: String {
        return  ""
    }
    
    public enum APIVersion: String {
        case
        v1 = ""
    }
}
