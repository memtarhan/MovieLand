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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - HomeViewImplementable

extension HomeViewController: HomeViewImplementable {
}
