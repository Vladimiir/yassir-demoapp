//
//  MoviesListViewModel.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    
    private var moviesService = MoviesService()
    
    @Published var movies: [MovieModel] = []
    
    func fetchMoviesList() {
        // TODO: show loader
        moviesService.fetchMoviesList { movies in
            DispatchQueue.main.async {
                self.movies = movies.results
            }
        }
    }
}
