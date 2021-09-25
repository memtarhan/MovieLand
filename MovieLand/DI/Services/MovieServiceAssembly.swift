//
//  MovieServiceAssembly.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation
import Swinject

class MovieServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MovieServiceImplementable.self) { _ in
            MovieService()
        }
    }
}
