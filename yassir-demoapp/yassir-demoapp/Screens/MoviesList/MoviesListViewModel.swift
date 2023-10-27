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
    
    @Published var moviesListModel: MoviesListModel?
    @Published var movies: [MovieModel] = []
    @Published var isLoadingMovies = false
    @Published var isLoadingMoreMovies = false
    @Published var selectedSorting = MoviesService.SortBy.popularityDesc.rawValue
    let sortingList = MoviesService.SortBy.allCases.map { $0.rawValue }
    
    private var page = 1
    
    var loadMoreMoviesTitle: String {
        "Load 20 movies more..."
    }
    
    var pageDescTitle: String {
        guard let moviesListModel else { return "" }
        return "Page \(moviesListModel.page) from \(moviesListModel.totalPages)"
    }
    
    var canShowPageCount: Bool {
        moviesListModel != nil
    }
    
    init() {
        // The initial loading
        isLoadingMovies = true
        fetchMoviesList()
    }
    
    func fetchMoviesList() {
        moviesService.fetchMoviesList(page: page,
                                      sortBy: selectedSorting) { moviesListModel in
            DispatchQueue.main.async {
                self.isLoadingMoreMovies = false
                self.isLoadingMovies = false
                self.moviesListModel = moviesListModel
                self.movies.append(contentsOf: moviesListModel.results)
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
