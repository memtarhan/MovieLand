//
//  Date+.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Foundation

extension Date {
    var year: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        
        if let year = components.year { return "\(year)" }
        else { return " - " }
    }

    var asMovieDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: self)
    }
}
