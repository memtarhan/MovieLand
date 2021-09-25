//
//  ViewControllerFactoryAssembly.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation
import Swinject

class ViewControllerFactoryAssembly: Assembly {
    private let assembler: Assembler

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    func assemble(container: Container) {
        container.register(ViewControllerFactoryImplementable.self) { _ in
            ViewControllerFactory(assembler: self.assembler)
        }
    }
}
