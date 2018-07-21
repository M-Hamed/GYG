//
//  Review.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import RealmSwift

public struct ReviewsData: Decodable {
    var total_reviews_comments =  0
    var data = [Review]()
}

public class Review: Object, Decodable {
    @objc dynamic var review_id: Int = 0
    @objc dynamic var rating: String = ""
    @objc dynamic var title: String? = ""
    @objc dynamic var message: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var foreignLanguage: Bool = false
    @objc dynamic var date: String = ""
    @objc dynamic var languageCode: String = ""
    @objc dynamic var reviewerName: String = ""
    @objc dynamic var reviewerCountry: String = ""
    
    override public static func primaryKey() -> String? {
        return "review_id"
    }
}
