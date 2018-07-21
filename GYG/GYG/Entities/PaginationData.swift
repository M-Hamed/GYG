//
//  PaginationData.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import Alamofire

public class PaginationData {
    var page: Int = 0
    var count = 10
    var rating = 0
    var sortBy = "date_of_review"
    var direction = "DESC"
    
    var isFirstPage: Bool {
        return page == 0
    }
    
    func asDictionary() -> [String: Any] {
        let params: Parameters =
            ["count" : count,
             "page" : page,
             "rating" : rating,
             "sortBy" : sortBy,
             "direction" : direction]
        return params
    }
    
    func toggleDirection() {
        if direction == "DESC" {
            direction = "ASC"
        } else {
            direction = "DESC"
        }
        
    }
    func increment() {
        self.page = page + 1
    }
    
}
