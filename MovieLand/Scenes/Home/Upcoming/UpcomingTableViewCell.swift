//
//  UpcomingTableViewCell.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Kingfisher
import UIKit

class UpcomingTableViewCell: UITableViewCell {
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var detailsButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        posterImageView.roundCorners()
        posterImageView.addBorders()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ model: Home.Upcoming) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        dateLabel.text = model.date

        let url = URL(string: model.poster)
        posterImageView.kf.setImage(with: url)
    }
}
