//
//  ServicesEndpoints.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

class ServicesEndpoints {
    
    static let apiKey = "82ec2b190a11fbde59cc8901b542e9f6"
    static let apiReadAccessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MmVjMmIxOTBhMTFmYmRlNTljYzg5MDFiNTQyZTlmNiIsInN1YiI6IjY1M2E3OTMzMjRmMmNlMDBlMjZhZTMzMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ZN_-7reaFksVPEJSJjclCaxMNi9Ku2HoxhzPoMm4inE"
    
    static let moviesPath = "https://api.themoviedb.org/3/discover/movie"
    static let imageSmallPath = "https://image.tmdb.org/t/p/w500"
    
    
    // TODO: make a func to 'addParam(...)'
//    static func moviesUrl(with param: String) -> URL? {
//        var path = moviesPath
//        path.append(page)
//        return URL(string: path)
//    }
    
    static func imageUrl(with imgPath: String) -> URL? {
        var path = imageSmallPath
        path.append(imgPath)
        return URL(string: path)
    }
}
