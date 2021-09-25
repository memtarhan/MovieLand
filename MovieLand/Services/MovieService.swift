//
//  MovieService.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Alamofire
import Foundation

protocol MovieServiceImplementable: APICallable {
    /**
     Retrieves  movies with given type and page

     - Parameter page: Current page
     - Parameter type: Type of movie
     - Parameter completionBlock: A completion block with success and/or failure messages
     */
    func retrieve(_ type: MovieType, page: Int, _ completionBlock: @escaping (Result<[MovieModel], NetworkError>) -> Void)

    /**
     Retrieves upcoming movies with given page

     - Parameter movie: Movie ID
     - Parameter completionBlock: A completion block with success and/or failure messages
     */
    func retrieveDetails(for movie: Int, _ completionBlock: @escaping (Result<MovieDetailsModel, NetworkError>) -> Void)
}

class MovieService: MovieServiceImplementable {
    func retrieve(_ type: MovieType, page: Int, _ completionBlock: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        guard Connectivity.isReachable else {
            completionBlock(.failure(NetworkError.noInternet))
            return
        }
        
        let url = "\(baseURL)/\(type.rawValue)?api_key=\(key)&language=en-US&page=\(page)"
        AF.request(url)
            .responseJSON { response in
                guard let data = response.data else {
                    completionBlock(.failure(NetworkError.invalidResponse))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.movieDate)
                    let response = try decoder.decode(MovieResponse.self, from: data)
                    let movies = response.results
                    completionBlock(.success(movies))

                } catch {
                    completionBlock(.failure(NetworkError.invalidResponse))
                }
            }
    }

    func retrieveDetails(for movie: Int, _ completionBlock: @escaping (Result<MovieDetailsModel, NetworkError>) -> Void) {
        let url = "\(baseURL)/\(movie)?api_key=\(key)&language=en-US"
        guard Connectivity.isReachable else {
            completionBlock(.failure(NetworkError.noInternet))
            return
        }
        
        AF.request(url)
            .responseJSON { response in
                guard let data = response.data else {
                    completionBlock(.failure(NetworkError.invalidResponse))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.movieDate)
                    let details = try decoder.decode(MovieDetailsModel.self, from: data)
                    completionBlock(.success(details))

                } catch {
                    completionBlock(.failure(NetworkError.invalidResponse))
                }
            }
    }
}
