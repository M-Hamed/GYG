//
//  ReviewsInteractor.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import RealmSwift

class ReviewsInteractor {

    public static func getReviews(pagination:PaginationData,
                    onSuccess: @escaping ([Review]) -> (),
                    onFailure: @escaping (Error) -> ()) {
        
        ReviewsService().get(
            tour: "berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776/reviews.json",
            pagination: pagination,
            onSuccess: { reviewsData in
                let realm = try! Realm()
                let reviews = reviewsData.data
                reviews.forEach { review in
                    try! realm.write {
                        realm.add(review, update: true)
                    }
                }
                onSuccess(reviews)
        }) { error in
            onFailure(error)
            print(error)
        }
    }
    
    public static func getOfflineReviews(pagination:PaginationData) -> [Review] {
        let realm = try! Realm()
        let sortedReviews = realm.objects(Review.self).sorted(byKeyPath: "date", ascending: pagination.direction == "ASC")
        return Array(sortedReviews)
    }
}
