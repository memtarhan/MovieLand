//
//  APICallable.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

protocol APICallable: AnyObject {
    var key: String { get } // API key
    var baseURL: String { get } // Base URL
}

extension APICallable {
    var key: String { return "f0a61db3949226c17c9a6bf4b5396164" }
    var baseURL: String { return "https://api.themoviedb.org/3/movie" }
}
