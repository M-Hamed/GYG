//
//  CreateReviewViewController.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import UIKit
import Cosmos

class CreateReviewViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var ratingView: CosmosView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.delegate = self
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        let review = Review()
        review.message = messageTextView.text
        review.title = titleTextField.text ?? ""
        review.author = userTextField.text ?? ""
        review.rating = ratingView.rating.description
        
        ReviewsService().create(review: review, onSuccess: { (review) in
            print(review)
                Activity.showAlert(message: "Created Succefully")
        }) { (error) in
            print(error)
        }
    }
}

extension CreateReviewViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        adjustHeight(textView)
    }
    
    func adjustHeight(_ textView: UITextView) {
        let width = textView.frame.width != 0 ? textView.frame.width : UIScreen.main.bounds.width
        let size = CGSize(width: width, height: .infinity)
        let sizeThatFits = textView.sizeThatFits(size)
        textView.constraints.forEach {
            if $0.firstAttribute == .height {
                $0.constant = sizeThatFits.height
            }
        }
    }
}
