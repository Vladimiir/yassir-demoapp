//
//  DatesManager.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 27.10.2023.
//

import Foundation

struct DatesManager {
    
    static func string(from date: Date?,
                       with formatter: DateFormatter) -> String {
        guard let date else { return "" }
        return formatter.string(from: date)
    }
}
