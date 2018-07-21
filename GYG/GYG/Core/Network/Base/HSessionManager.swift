//
//  HSessionManager.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import Alamofire

final class HSessionManager: NSObject {
    
    private static var sessionManager: SessionManager?
    
    static var current: SessionManager {
        if sessionManager == nil {
            sessionManager = SessionManager()
        }
        
        return sessionManager!
    }
    
    private override init() {
        super.init()
    }
    
    static func cancelAllRequests() {
        sessionManager?.session.invalidateAndCancel()
        sessionManager = nil
    }
}
