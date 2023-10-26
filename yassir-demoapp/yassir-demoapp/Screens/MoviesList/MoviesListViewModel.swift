//
//  MoviesListViewModel.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation
import Combine

class MoviesListViewModel: ObservableObject {
    
    // Mostly for assigning values I prefer to use DI (Swinject, Typhoon, swift-dependencies)
    // For SwiftUI in the last projet I used "https://github.com/pointfreeco/swift-dependencies"
    // But for the demo project I will create dependencies manually
    private var moviesService = MoviesService()
    
    @Published var movies: [MovieModel] = []
    @Published var isLoadingMoreMovies = false
    @Published var selectedSorting = MoviesService.SortBy.popularityDesc.rawValue
    let sortingList = MoviesService.SortBy.allCases.map { $0.rawValue }
    
    private var page = 1
    
    var loadMoreMoviesTitle: String {
        "Load 20 movies more..."
    }
    
    init() {
        fetchMoviesList()
    }
    
    func fetchMoviesList() {
        // TODO: show loader
        
        moviesService.fetchMoviesList(page: page,
                                      sortBy: selectedSorting) { movies in
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
    
    func sortByAction() {
        movies = []
        page = 1
        fetchMoviesList()
    }
}
