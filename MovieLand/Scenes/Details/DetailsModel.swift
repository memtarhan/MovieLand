//
//  DetailsModel.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

struct Details {
    struct Model {
        let title: String
        let description: String
        let rate: NSAttributedString
        let date: String
        let backdrop: String
        let imdb: URL?
    }
    
    struct Alert {
        let title: String
        let message: String
    }
}
