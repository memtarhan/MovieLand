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
            let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
            let viewModel = r.resolve(HomeViewModelImplementable.self)!
            let factory = r.resolve(ViewControllerFactoryImplementable.self)!

            view.viewModel = viewModel
            view.factory = factory
            viewModel.view = view

            return view
        }

        container.register(HomeViewModelImplementable.self) { r in
            HomeViewModel(movieService: r.resolve(MovieServiceImplementable.self)!)
        }
    }
}
