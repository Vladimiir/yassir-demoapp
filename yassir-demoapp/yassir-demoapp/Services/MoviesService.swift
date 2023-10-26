//
//  MoviesService.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

class MoviesService: ObservableObject {
    
    func fetchMoviesList(handler: ([String]) -> ()){
        
        handler(["123", "456"])
    }
}
