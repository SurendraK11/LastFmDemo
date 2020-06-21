//
//  AlbumDetailViewViewModel.swift
//  DemoLastFm
//
//  Created by Surendra on 18/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

protocol AlbumDetailViewViewModelProtocol {
    
    /// Get artist name
    var artist: String {get}
    
    /// Get album name
    var name: String {get}
    
    /// Get url of extra large image
    var extralargeImageUrl: URL? {get}
}

struct AlbumDetailViewViewModel {
    
    let album: Album
    init(withAlbum album: Album) {
        self.album = album
    }
    
}

extension AlbumDetailViewViewModel: AlbumDetailViewViewModelProtocol {
    
    var name: String {
        return album.name
    }
    
    var artist: String {
        return album.artist
    }
    
    var extralargeImageUrl: URL? {
        guard let extralargeImage = album.image.filter({ $0.size == .extralarge
        }).first else {
            return nil
        }
        return URL(string: extralargeImage.url)
    }
}
