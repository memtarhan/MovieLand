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

    func displayUpcoming(_ models: [Home.Upcoming])
    func displayNowPlaying(_ models: [Home.NowPlaying])
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

    private var upcomings: [Home.Upcoming] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Actions

    @objc private func didRefresh(_ sender: AnyObject) {
        upcomings = []
        if let nowPlayingView = tableView.headerView(forSection: 0) as? NowPlayingView {
            nowPlayingView.refresh()
        }
        viewModel?.refresh()
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

        let cellRowHeight: CGFloat = view.frame.height / 7
        tableView.rowHeight = cellRowHeight
        tableView.estimatedRowHeight = cellRowHeight

        viewModel?.presenNowPlaying()
        viewModel?.presentUpcoming()
    }
}

// MARK: - TableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }

        let model = upcomings[indexPath.row]
        cell.configure(model)

        return cell
    }
}

// MARK: - TableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier) as! NowPlayingView
        headerView.delegate = self
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let width = tableView.frame.width
        let height = (width / 16) * 9 // 16/9 ratio

        return height
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == upcomings.count - 1 {
            viewModel?.presentUpcoming()
        }
    }
}

// MARK: - NowPlayingViewDelegate

extension HomeViewController: NowPlayingViewDelegate {
    func didViewLast() {
        viewModel?.presenNowPlaying()
    }
}

// MARK: - HomeViewImplementable

extension HomeViewController: HomeViewImplementable {
    func displayUpcoming(_ models: [Home.Upcoming]) {
        upcomings.append(contentsOf: models)
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }

    func displayNowPlaying(_ models: [Home.NowPlaying]) {
        DispatchQueue.main.async {
            if let nowPlayingView = self.tableView.headerView(forSection: 0) as? NowPlayingView {
                nowPlayingView.display(models)
            }
        }
    }
}
