//
//  NowPlayingView.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import UIKit

protocol NowPlayingViewDelegate {
    func didViewLast()
}

class NowPlayingView: UITableViewHeaderFooterView {
    // MARK: - Outlets

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!

    // MARK: - Properties

    var delegate: NowPlayingViewDelegate?

    private let cellNibIdentifier = "NowPlayingCollectionViewCell"
    private let cellReuseIdentifier = "Now Playing"

    private var playings: [Home.NowPlaying] = []

    override func awakeFromNib() {
        super.awakeFromNib()

        let cellNib = UINib(nibName: cellNibIdentifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)

        collectionView.dataSource = self
        collectionView.delegate = self

        pageControl.numberOfPages = playings.count
    }

    func display(_ playings: [Home.NowPlaying]) {
        self.playings.append(contentsOf: playings)
        pageControl.numberOfPages = self.playings.count
        collectionView.reloadData()
    }

    func refresh() {
        playings = []
        pageControl.numberOfPages = playings.count
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension NowPlayingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? NowPlayingCollectionViewCell else {
            return UICollectionViewCell()
        }

        let model = playings[indexPath.row]
        cell.configure(model)

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension NowPlayingView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = indexPath.row
        pageControl.currentPage = index

        if index == playings.count - 1 {
            delegate?.didViewLast()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NowPlayingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = (width / 16) * 9 // 16/9 ratio

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
