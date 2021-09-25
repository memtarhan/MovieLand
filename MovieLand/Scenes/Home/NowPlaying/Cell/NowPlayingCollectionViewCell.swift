//
//  NowPlayingCollectionViewCell.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Kingfisher
import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var backdropImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model: Home.NowPlaying) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description

        let url = URL(string: model.backdrop)
        backdropImageView.kf.setImage(with: url)
    }
}
