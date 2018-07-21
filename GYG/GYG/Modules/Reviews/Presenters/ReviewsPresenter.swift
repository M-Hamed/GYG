//
//  ReviewsPresenter.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation

class ReviewsPresenter {
    
    fileprivate var reviewsData: ReviewsData
    fileprivate var pagination: PaginationData
    
    var updateLoadingStatus: ((Bool)->())?
    var loadedReviews: ((ReviewsData)->())?
    var failedToLoad: ((Error)->())?
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?(isLoading)
        }
    }
    
    var numberOfCells: Int {
        return reviewsData.data.count
    }
    
    var totalReviews: Int {
        return reviewsData.total_reviews_comments
    }
    
    func reviewAtIndex(at indexPath: IndexPath) -> Review {
        return reviewsData.data[indexPath.row]
    }
    
    init() {
        pagination = PaginationData()
        reviewsData = ReviewsData(total_reviews_comments: 0, data: [])
    }

    
    
    func loadReviews(reset: Bool) {
        guard !isLoading else { return }
        
        ReviewsInteractor.getReviews(pagination: self.pagination, onSuccess: {  [weak self]  reviewsData in
            guard let `self` = self else { return }
            self.isLoading = false
            
            if reset {
                self.resetData()
            }
            self.pagination.increment()
            self.reviewsData.data += reviewsData.data
            self.loadedReviews?(reviewsData)
        }) {  [weak self]  error in
            guard let `self` = self else { return }
            self.isLoading = false
            self.failedToLoad?(error)
        }
    }
    
    private func resetData() {
        pagination = PaginationData()
        reviewsData = ReviewsData(total_reviews_comments: 0, data: [])
    }
}
