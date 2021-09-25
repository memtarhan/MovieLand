//
//  HomeModel.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

struct Home {
    struct NowPlaying {
        let title: String
        let description: String
        let backdrop: String
        let id: Int
    }

    struct Upcoming {
        let title: String
        let description: String
        let date: String
        let poster: String
        let id: Int
    }
}
