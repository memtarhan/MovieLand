//
//  NetworkError.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse

    var title: String {
        switch self {
        case .invalidURL: return "URL is invalid"
        case .invalidResponse: return "Response is invalid"
        }
    }

    var message: String {
        switch self {
        case .invalidURL: return "URL is invalid"
        case .invalidResponse: return "Response is invalid"
        }
    }
}
