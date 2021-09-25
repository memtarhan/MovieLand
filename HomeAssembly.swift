//
//  HomeAssembly.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Swinject
import UIKit

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewImplementable.self) { r in
            let viewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
            let viewModel = r.resolve(HomeViewModelImplementable.self)!

            viewController.viewModel = viewModel

            return viewController
        }

        container.register(HomeViewModelImplementable.self) { _ in
            HomeViewModel()
        }
    }
}
