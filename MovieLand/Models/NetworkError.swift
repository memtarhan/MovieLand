//
//  NetworkError.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case invalidURL
    case invalidResponse

    var title: String {
        switch self {
        case .noInternet: return "No internet"
        case .invalidURL: return "URL is invalid"
        case .invalidResponse: return "Response is invalid"
        }
    }

    var message: String {
        switch self {
        case .noInternet: return "Please connect your device to internet"
        case .invalidURL: return "Please try again"
        case .invalidResponse: return "Please try again"
        }
    }
}
