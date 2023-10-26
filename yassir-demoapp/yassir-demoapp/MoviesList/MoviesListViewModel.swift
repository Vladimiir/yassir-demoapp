//
//  MoviesListViewModel.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    
    private var moviesService = MoviesService()
    
    @Published var movies: [String] = []
    
    func fetchMoviesList() {
        moviesService.fetchMoviesList { movies in
            self.movies = movies
        }
    }
}
