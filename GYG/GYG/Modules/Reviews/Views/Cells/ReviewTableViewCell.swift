//
//  ReviewTableViewCell.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(review: Review) {
        titleLabel.text = review.title
        ratingView.rating =  Double(review.rating) ?? 0
        messageLabel.text = review.message
        subtitleLabel.text = review.author + " . " + review.date
    }
    
}
