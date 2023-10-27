//
//  PathConstructor.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 27.10.2023.
//

import Foundation

struct URLConstructor {
    
    enum Params: String {
        case page
        case sortBy = "sort_by"
    }
    
    static func addParams(params: [Params: String],
                          for path: String) -> URL? {
        var newPath = ServicesEndpoints.moviesPath
        
        params.forEach {
            if let last = newPath.last,
               String(last) != "?" {
                // Need to add the separator
                newPath.append("&")
            }
            newPath.append("\($0.key.rawValue)=\($0.value)")
        }
        
        return URL(string: newPath)
    }
    
    static func imageUrl(with imgPath: String?) -> URL? {
        guard let imgPath else { return nil }
        
        var path = ServicesEndpoints.imageSmallPath
        path.append(imgPath)
        return URL(string: path)
    }
}
