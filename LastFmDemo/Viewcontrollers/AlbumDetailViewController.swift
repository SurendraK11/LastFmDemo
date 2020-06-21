//
//  AlbumDetailViewController.swift
//  DemoLastFm
//
//  Created by Surendra on 19/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import UIKit
import Kingfisher

final class AlbumDetailViewController: UIViewController {
    
    @IBOutlet private var albumName: UILabel!
    @IBOutlet private var largeLogo: UIImageView!
    @IBOutlet private var artist: UILabel!
    
    var viewModel: AlbumDetailViewViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail".localizedString
        setupUI()
    }
    
    deinit {
        debugPrint("deinit - AlbumDetailViewController")
    }
    
    private func setupUI() {
        artist.text = viewModel.artist
        albumName.text = viewModel.name

        largeLogo.kf.indicatorType = .activity
        largeLogo.kf.setImage(with: viewModel.extralargeImageUrl)
    }
}
