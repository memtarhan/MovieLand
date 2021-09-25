//
//  ViewControllerFactory.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation
import Swinject

protocol ViewControllerFactoryImplementable {
    var details: DetailsViewImplementable { get }
    var home: HomeViewImplementable { get }
}

class ViewControllerFactory: ViewControllerFactoryImplementable {
    private let assembler: Assembler

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    var details: DetailsViewImplementable { assembler.resolver.resolve(DetailsViewImplementable.self)! }
    var home: HomeViewImplementable { assembler.resolver.resolve(HomeViewImplementable.self)! }
}
