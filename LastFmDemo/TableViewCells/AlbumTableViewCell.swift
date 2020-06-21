//
//  AlbumTableViewCell.swift
//  DemoLastFm
//
//  Created by Surendra on 19/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import UIKit
import Kingfisher

final class AlbumTableViewCell: UITableViewCell {
    @IBOutlet private var logo: UIImageView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var indicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupCell(using: .none)
    }
    
    func setupCell(using viewModel: AlbumTableViewCellViewModelProtocal?) {
        guard let _ = viewModel else {
            // cell will act like loading cell
            logo.alpha = 0
            name.alpha = 0
            indicatorView.startAnimating()
            return
        }
        
        // cell will act like content cell
        logo.alpha = 1
        name.alpha = 1
        indicatorView.stopAnimating()
        name.text = viewModel!.name
        logo.kf.indicatorType = .activity
        logo.kf.setImage(with: viewModel?.smallImageUrl)
    }
}
