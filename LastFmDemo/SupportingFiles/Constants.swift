//
//  AppConstants.swift
//  DemoLastFm
//
//  Created by Surendra on 18/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

enum APIConstants {
    static let scheme = "http"
    static let host = "ws.audioscrobbler.com"
    static let path = "/2.0/"
    static let apiKey = "d1fc847c81855b6b8c7f340f7f7f00a1"
}



enum StoryboardCellIdentifiers {
    static let albumTableViewCell = "AlbumTableViewCell"
}

enum StoryboardSegueIdentifiers {
    static let detail = "DetailViewController"
}
