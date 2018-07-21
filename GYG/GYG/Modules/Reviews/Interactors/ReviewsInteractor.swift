//
//  ReviewsInteractor.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation

class ReviewsInteractor {

    public static func getReviews(pagination:PaginationData,
                    onSuccess: @escaping (ReviewsData) -> (),
                    onFailure: @escaping (Error) -> ()) {
        
        let pagination = PaginationData()
        ReviewsService().get(
            tour: "berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776/reviews.json",
            pagination: pagination,
            onSuccess: { reviewsData in
                onSuccess(reviewsData)
        }) { error in
            print(error)
        }
        
    }
}
