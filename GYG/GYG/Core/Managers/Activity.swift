//
//  Activity.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import UIKit

class Activity {
    
    static func startAnimating() {
        if let view = UIApplication.shared.keyWindow?.rootViewController?.view {
            customActivityIndicatory(view, startAnimate: true)
        }
    }
    
    static func stopAnimating() {
        if let view = UIApplication.shared.keyWindow?.rootViewController?.view {
            customActivityIndicatory(view, startAnimate: false)
        }
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
    
    private static func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool = true) {
        let mainContainer = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        mainContainer.backgroundColor = UIColor.lightGray
        mainContainer.alpha = 0.5
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false
        
        let backgroudView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        backgroudView.center = viewContainer.center
        backgroudView.backgroundColor = UIColor(hex: "444444")
        backgroudView.alpha = 0.8
        backgroudView.roundCorners(withRadius: 15)
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: backgroudView.frame.size.width / 2, y: backgroudView.frame.size.height / 2)
        if startAnimate {
            backgroudView.addSubview(activityIndicator)
            mainContainer.addSubview(backgroudView)
            viewContainer.addSubview(mainContainer)
            activityIndicator.startAnimating()
        } else {
            for subview in viewContainer.subviews{
                if subview.tag == 789456123 {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}

