//
//  AlertDisplayer.swift
//  DemoLastFm
//
//  Created by Surendra on 19/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Responsible to show alert
    /// - Parameters:
    ///   - title: title
    ///   - message: message to display
    ///   - actions: actions
    func showAlert(_ title: String, message: String, actions: [UIAlertAction]?) {
        guard presentedViewController == nil else {
          return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           actions?.forEach { action in
             alertController.addAction(action)
           }
        present(alertController, animated: true)
    }
}

