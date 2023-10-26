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
    @Published var isLoadingMoreMovies = false
    
    private var page = 1
    
    var loadMoreMoviesTitle: String {
        "Load 20 movies more..."
    }
    
    init() {
        fetchMoviesList()
    }
    
    func fetchMoviesList() {
        // TODO: show loader
        
        moviesService.fetchMoviesList(page: page) { movies in
            DispatchQueue.main.async {
                self.isLoadingMoreMovies = false
                self.movies.append(contentsOf: movies.results)
            }
        }
    }
    
    func loadMoreMoviesButtonAction() {
        page += 1
        isLoadingMoreMovies = true
        fetchMoviesList()
    }
}
