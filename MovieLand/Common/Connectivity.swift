//
//  Connectivity.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Alamofire
import Foundation

struct Connectivity {
    private static let shared = NetworkReachabilityManager()!
    static var isReachable: Bool {
        return shared.isReachable
    }
}
