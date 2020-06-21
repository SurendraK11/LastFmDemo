//
//  String.swift
//  DemoLastFm
//
//  Created by Surendra on 19/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

extension String {
    /// Responsible to return localized string
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
}
