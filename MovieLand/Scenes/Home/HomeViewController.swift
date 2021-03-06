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
    var factory: ViewControllerFactoryImplementable? { get set }

    func displayUpcoming(_ models: [Home.Upcoming])
    func displayNowPlaying(_ models: [Home.NowPlaying])
    func displayAlert(_ alert: Home.Alert)
}

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelImplementable?
    var factory: ViewControllerFactoryImplementable?

    // MARK: - Outlets

    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
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

    @objc private func didRefresh(_ sender: UIRefreshControl) {
        upcomings = []
        if let nowPlayingView = tableView.headerView(forSection: 0) as? NowPlayingView {
            nowPlayingView.refresh()
        }
        viewModel?.refresh()
    }

    @objc private func didTapDetails(_ sender: UIButton) {
        let index = sender.tag
        let movie = upcomings[index]
        navigateToDetails(movie.id)
    }

    // MARK: - Navigations

    private func navigateToDetails(_ id: Int) {
        let details = factory?.details
        details?.movieId = id
        guard let detailsViewController = details as? UIViewController else { return }
        let navigationController = UINavigationController(rootViewController: detailsViewController)

        present(navigationController, animated: true, completion: nil)
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

        let index = indexPath.row
        if index < upcomings.count {
            let model = upcomings[index]
            cell.detailsButton.tag = index
            cell.detailsButton.addTarget(self, action: #selector(didTapDetails(_:)), for: .touchUpInside)
            cell.configure(model)
        }

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = upcomings[indexPath.row]
        navigateToDetails(movie.id)
    }
}

// MARK: - NowPlayingViewDelegate

extension HomeViewController: NowPlayingViewDelegate {
    func nowPlayingDidViewLast() {
        viewModel?.presenNowPlaying()
    }

    func nowPlayingDidView(movie id: Int) {
        navigateToDetails(id)
    }
}

// MARK: - HomeViewImplementable

extension HomeViewController: HomeViewImplementable {
    func displayUpcoming(_ models: [Home.Upcoming]) {
        upcomings.append(contentsOf: models)
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    func displayNowPlaying(_ models: [Home.NowPlaying]) {
        DispatchQueue.main.async {
            if let nowPlayingView = self.tableView.headerView(forSection: 0) as? NowPlayingView {
                nowPlayingView.display(models)
            }
        }
    }

    func displayAlert(_ alert: Home.Alert) {
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }

            self.activityIndicator.stopAnimating()
            self.displayAlert(withTitle: alert.title, message: alert.message)
        }
    }
}
