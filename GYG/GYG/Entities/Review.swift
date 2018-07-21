//
//  Review.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation

public struct ReviewsData: Decodable {
    var total_reviews_comments =  0
    var data = [Review]()
}

public struct Review: Decodable {
    var review_id: Int
    var rating: String
    var title: String
    var message: String
    var author: String
    var foreignLanguage: Bool
    var date: String
    var languageCode: String
    var traveler_type: String
    var reviewerName: String
    var reviewerCountry: String
}
