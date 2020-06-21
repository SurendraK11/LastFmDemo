//
//  Album.swift
//  DemoLastFm
//
//  Created by Surendra on 18/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    let name, artist: String
    let url: String
    let image: [Image]
    let streamable: String
    
    struct Image: Codable {
        let url: String
        let size: Size
        
        enum CodingKeys: String, CodingKey {
            case url = "#text"
            case size
        }
    }
    
    enum Size: String, Codable {
        case extralarge = "extralarge"
        case large = "large"
        case medium = "medium"
        case small = "small"
    }
}
