//
//  MovieResponse.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

class MovieResponse: Codable {
    var page: Int
    var results: [MovieModel]
}

class MovieModel: Codable {
    var title: String?
}

enum MovieType: String {
    case nowPlaying = "now_playing"
    case upcoming
}
