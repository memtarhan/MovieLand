//
//  HomeViewModel.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

protocol HomeViewModelImplementable: AnyObject {
    func presenNowPlaying()
    func presentUpcoming()
}

class HomeViewModel: HomeViewModelImplementable {
    private let movieService: MovieServiceImplementable

    init(movieService: MovieServiceImplementable) {
        self.movieService = movieService
    }

    func presenNowPlaying() {
        movieService.retrieve(.nowPlaying, page: 1) { _ in
        }
    }

    func presentUpcoming() {
        movieService.retrieve(.upcoming, page: 1) { _ in
        }
    }
}
