//
//  UIView+.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(_ radius: CGFloat = 12) {
        layer.cornerRadius = radius
    }

    func addBorders(_ color: UIColor = .lightText) {
        layer.borderWidth = 0.2
        layer.borderColor = color.cgColor
    }
}
