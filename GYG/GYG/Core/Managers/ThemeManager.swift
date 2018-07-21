//
//  ThemeManager.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import Foundation
import UIKit

class ThemeManager {
    private init() {}
    
    static func setupTheme() {
        updateColors()
    }
    
    static func updateColors() {
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().tintColor      = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor   = UIColor.primary
        if #available(iOS 11.0, *) {
            UISearchBar.appearance().tintColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        }
    }
}
