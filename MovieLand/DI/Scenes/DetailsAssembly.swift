//
//  DetailsAssembly.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Swinject
import UIKit

class DetailsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DetailsViewImplementable.self) { r in
            let view = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
            let viewModel = r.resolve(DetailsViewModelImplementable.self)!

            view.viewModel = viewModel
            viewModel.view = view

            return view
        }

        container.register(DetailsViewModelImplementable.self) { _ in
            DetailsViewModel()
        }
    }
}
