//
//  HomeViewModel.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

protocol HomeViewModelImplementable: AnyObject {
    var view: HomeViewImplementable? { get set }

    func presenNowPlaying()
    func presentUpcoming()
    func refresh()
}

class HomeViewModel: HomeViewModelImplementable {
    var view: HomeViewImplementable?

    private let movieService: MovieServiceImplementable

    private var upcomingsPage = 0
    private var nowPlayingsPage = 0

    init(movieService: MovieServiceImplementable) {
        self.movieService = movieService
    }

    func presenNowPlaying() {
        nowPlayingsPage += 1
        movieService.retrieve(.nowPlaying, page: nowPlayingsPage) { result in
            switch result {
            case let .success(movies):
                let models = movies.map { movie -> Home.NowPlaying in
                    var title = movie.title ?? "No title"
                    if let year = movie.date?.year {
                        title = "\(title)(\(year)"
                    }

                    return Home.NowPlaying(title: title,
                                           description: movie.overview ?? "No description",
                                           backdrop: movie.backdrop ?? "",
                                           id: movie.id)
                }

                self.view?.displayNowPlaying(models)

            case let .failure(error):
                let alert = Home.Alert(title: error.title, message: error.message)
                self.view?.displayAlert(alert)
            }
        }
    }

    func presentUpcoming() {
        upcomingsPage += 1
        movieService.retrieve(.upcoming, page: upcomingsPage) { result in
            switch result {
            case let .success(movies):
                let models = movies.map { movie -> Home.Upcoming in
                    var title = movie.title ?? "No title"
                    if let year = movie.date?.year {
                        title = "\(title)(\(year)"
                    }

                    return Home.Upcoming(title: title,
                                         description: movie.overview ?? "No description",
                                         date: movie.date?.asMovieDate ?? "No date",
                                         poster: movie.poster ?? "",
                                         id: movie.id)
                }

                self.view?.displayUpcoming(models)

            case let .failure(error):
                let alert = Home.Alert(title: error.title, message: error.message)
                self.view?.displayAlert(alert)
            }
        }
    }

    func refresh() {
        upcomingsPage = 0
        nowPlayingsPage = 0
        presentUpcoming()
        presenNowPlaying()
    }
}
