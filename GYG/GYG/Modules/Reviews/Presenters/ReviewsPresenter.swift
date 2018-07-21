//
//  ReviewsPresenter.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation

class ReviewsPresenter {
    
    fileprivate var reviews: [Review]
    fileprivate var pagination: PaginationData
    
    var updateLoadingStatus: ((Bool)->())?
    var loadedReviews: (()->())?
    var failedToLoad: ((Error)->())?
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?(isLoading)
        }
    }
    
    var numberOfCells: Int {
        return reviews.count
    }
    
    func reviewAtIndex(at indexPath: IndexPath) -> Review {
        return reviews[indexPath.row]
    }
    
    init() {
        pagination = PaginationData()
        reviews = []
    }

    func loadReviews(reset: Bool) {
        guard !isLoading else { return }
        if reviews.isEmpty {// Get Offline Reviews
           reviews = ReviewsInteractor.getOfflineReviews(pagination: pagination)
            if !reviews.isEmpty {
                Activity.stopAnimating()
            }
        }
        
        isLoading = true
        ReviewsInteractor.getReviews(pagination: self.pagination, onSuccess: {  [weak self]  reviews in
            guard let `self` = self else { return }
            self.isLoading = false
            
            if reset {
                self.resetData()
            }
            if self.pagination.isFirstPage {
                self.reviews = []
            }
            self.pagination.increment()
            self.reviews += reviews
            self.loadedReviews?()
        }) {  [weak self]  error in
            guard let `self` = self else { return }
            self.isLoading = false
            self.failedToLoad?(error)
        }
    }
    
    func toggleFilter() {
        pagination.toggleDirection()
        loadReviews(reset: true)
    }
    
    private func resetData() {
        pagination.page = 0
        reviews = []
    }
}
