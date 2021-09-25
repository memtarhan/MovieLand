//
//  NowPlayingView.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import UIKit

class NowPlayingView: UITableViewHeaderFooterView {
    // MARK: - Outlets

    @IBOutlet var collectionView: UICollectionView!

    // MARK: - Properties

    private let cellNibIdentifier = "NowPlayingCollectionViewCell"
    private let cellReuseIdentifier = "Now Playing"

    override func awakeFromNib() {
        super.awakeFromNib()

        let cellNib = UINib(nibName: cellNibIdentifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension NowPlayingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? NowPlayingCollectionViewCell else {
            return UICollectionViewCell()
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension NowPlayingView: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NowPlayingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
