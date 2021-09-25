//
//  HomeViewController.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import UIKit

protocol HomeViewImplementable: AnyObject {
    var viewModel: HomeViewModelImplementable? { get set }
}

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelImplementable?

    // MARK: - Outlets

    @IBOutlet var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    // MARK: - Properties

    private let cellNibIdentifier = "UpcomingTableViewCell"
    private let cellReuseIdentifier = "Upcoming"
    private let headerNibIdentifier = "NowPlayingView"
    private let headerReuseIdentifier = "NowPlayingView"
    private let cellRowHeight: CGFloat = 160

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Actions

    @objc private func didRefresh(_ sender: AnyObject) {
        // TODO: Refresh data

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.refreshControl.endRefreshing()
        }
    }

    private func setup() {
        let cellNib = UINib(nibName: cellNibIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)

        let headerNib = UINib(nibName: headerNibIdentifier, bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = cellRowHeight
        tableView.estimatedRowHeight = cellRowHeight
    }
}

// MARK: - TableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }
}

// MARK: - TableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier) as! NowPlayingView
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 320
    }
}

// MARK: - HomeViewImplementable

extension HomeViewController: HomeViewImplementable {
}
