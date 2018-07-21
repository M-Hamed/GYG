//
//  ReviewsService.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import Alamofire

public class ReviewsService {
    public func get(tour: String,
                               pagination:PaginationData,
                               onSuccess: @escaping (ReviewsData) -> (),
                               onFailure: @escaping (Error) -> ()) {
        
        let request = ReviewsRouter.get(
            tour:tour,
            parameters: pagination.asDictionary())
        
        HNetwork.request(request: request, onSuccess: { dataResponse, result in
            do {
                let reviewsData = try self.parse(data: dataResponse.data!)
                onSuccess(reviewsData)
            } catch let jsonErr {
                onFailure(jsonErr)
            }
            
        }) { dataResponse, error in
            onFailure(error)
        }
    }
    
    public func create(review: Review,
                       onSuccess: @escaping (Review) -> (),
                       onFailure: @escaping (Error) -> ()) {
        
        //Pass the review data to the API
        let params: Parameters = ["title": review.title ?? "",
                                  "message": review.message,
                                  "author": review.author,
                                  "date": Date(),
                                  "rating": review.rating]
        
        let request = ReviewsRouter.create(parameters: params)
        MockService().createReview(review: review, onSuccess: { review in
            onSuccess(review)
        }) { (error) in
            onFailure(error)
        }
    }
    
    func parse(data: Data) throws -> ReviewsData {
        do {
            let reviewsData = try JSONDecoder().decode(ReviewsData.self, from: data)
            return reviewsData
        } catch let jsonErr {
            throw jsonErr
        }
    }
    
}
