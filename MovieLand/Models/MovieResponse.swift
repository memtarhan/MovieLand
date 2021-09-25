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
    var overview: String?
    var poster: String?
    var date: Date?

    enum CodingKeys: String, CodingKey {
        case title, overview
        case poster = "poster_path"
        case date = "release_date"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        date = try values.decode(Date.self, forKey: .date)

        if let photoId = try? values.decode(String.self, forKey: .poster) {
            poster = "https://image.tmdb.org/t/p/original\(photoId)"
        }
    }
}

enum MovieType: String {
    case nowPlaying = "now_playing"
    case upcoming
}
