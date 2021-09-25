//
//  DetailsViewController.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import UIKit

protocol DetailsViewImplementable: AnyObject {
    var viewModel: DetailsViewModelImplementable? { get set }
}

class DetailsViewController: UIViewController {
    var viewModel: DetailsViewModelImplementable?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - DetailsViewImplementable

extension DetailsViewController: DetailsViewImplementable {
}
