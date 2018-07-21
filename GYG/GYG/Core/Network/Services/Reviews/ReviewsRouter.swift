//
//  ReviewsRouter.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import Alamofire

enum ReviewsRouter: HURLRequestConvertible {
    
    case get(tour: String, parameters: Parameters)
    case create(parameters: Parameters)
    
    var name: String {
        switch self {
        case .get(let tour, _): return tour
        case .create( _): return ""
        }
    }
    
    var path: String {
        switch self {
        case .get:    return "\(name)"
        case .create:    return "\(name)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:     return .get
        case .create:  return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .get( _, let parameters) : return parameters
        case .create(let parameters) : return parameters
        }
    }
}
