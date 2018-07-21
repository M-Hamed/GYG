//
//  Activity.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class Activity {
    
    static func startAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    }
    
    static func stopAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    static func showAlert(_ viewController: UIViewController? = nil,
                          message: String,
                          title: String? = nil) {
        
        var viewController = viewController
        if viewController == nil {
            viewController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        viewController?.present(alert, animated: true, completion: nil)
    }
}

