//
//  DateFormats.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 27.10.2023.
//

import Foundation

extension DateFormatter {
    
    static let yyyyMMdd: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    static let MMMyyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter
    }()
}
