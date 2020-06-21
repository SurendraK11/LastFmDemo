//
//  AlbumTableViewCellViewModel.swift
//  DemoLastFm
//
//  Created by Surendra on 19/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

protocol AlbumTableViewCellViewModelProtocal {
    /// Get album name
    var name: String {get}
    
    /// Get url of small image
    var smallImageUrl: URL? {get}
}

struct AlbumTableViewCellViewModel {
    private var album: Album
    
    init(withAlbum album: Album) {
        self.album = album
    }
}


extension AlbumTableViewCellViewModel: AlbumTableViewCellViewModelProtocal {
    
    var name: String {
        album.name
    }
    
    var smallImageUrl: URL? {
        guard let samllImage = album.image.filter({ $0.size == .small
        }).first, let url =  URL(string: samllImage.url) else {
            return nil
        }
        
        return url
    }
}
