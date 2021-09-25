//
//  DetailsViewModel.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

protocol DetailsViewModelImplementable: AnyObject {
    var view: DetailsViewImplementable? { get set }
}

class DetailsViewModel: DetailsViewModelImplementable {
    var view: DetailsViewImplementable?
}
