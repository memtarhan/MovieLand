//
//  DetailsViewModel.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import UIKit

protocol DetailsViewModelImplementable: AnyObject {
    var view: DetailsViewImplementable? { get set }

    func display(_ movie: Int)
}

class DetailsViewModel: DetailsViewModelImplementable {
    var view: DetailsViewImplementable?

    private let movieService: MovieServiceImplementable

    init(movieService: MovieServiceImplementable) {
        self.movieService = movieService
    }

    func display(_ movie: Int) {
        movieService.retrieveDetails(for: movie) { result in
            switch result {
            case let .success(details):
                var title = details.title ?? ""
                if let year = details.date?.year {
                    title = "\(title)(\(year)"
                }

                let rate = "\(details.rate ?? 0.0)/10"
                let range = (rate as NSString).range(of: "/10")

                let attributedRate = NSMutableAttributedString(string: rate)
                attributedRate.addAttribute(.foregroundColor, value: UIColor.secondaryLabel, range: range)
                attributedRate.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: (rate as NSString).range(of: rate))

                var imdbURL: URL?

                if let imdb = details.imdb {
                    let url = "https://www.imdb.com/title/\(imdb)/"
                    imdbURL = URL(string: url)
                }
                let model = Details.Model(title: title,
                                          description: details.overview ?? "",
                                          rate: attributedRate,
                                          date: details.date?.asMovieDate ?? "",
                                          backdrop: details.backdrop ?? "",
                                          imdb: imdbURL)

                self.view?.display(model)
                
            case let .failure(error):
                let alert = Details.Alert(title: error.title, message: error.message)
                self.view?.displayAlert(alert)
            }
        }
    }
}
