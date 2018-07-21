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
    var page = 0
    var count = 10
    var rating = 0
    var sortBy = "date_of_review"
    var direction = "DESC"
    
    var isFirstPage: Bool {
        return page == 0
    }
    
    func asDictionary() -> [String: Any] {
        let params: Parameters =
            ["count" : String(describing: count),
             "page" : String(describing: page),
             "rating" : String(describing: rating),
             "sortBy" : sortBy,
             "direction" : direction]
        return params
    }
    
    func increment() {
        page += 1
    }
    
}
