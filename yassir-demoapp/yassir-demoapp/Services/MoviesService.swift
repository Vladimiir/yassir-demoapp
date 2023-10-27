//
//  MoviesService.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

/// Using abstraction will also allow us to simplify writing unit-tests
protocol IMoviesService {
    
    /// Fetch movies data from provided page and other params
    /// - Parameters:
    ///   - page: number of the page from 1
    ///   - sortBy: sorting movies
    ///   - handler: completion handler
    func fetchMoviesList(page: Int,
                         sortBy: String,
                         handler: @escaping (MoviesListModel?) -> ())
    
    func fetchMovieDetails(id: Int,
                           handler: @escaping (MovieDetailsModel?) -> ())
}

class MoviesService: ObservableObject, IMoviesService {
    
    // Mostly for assigning values I prefer to use DI (Swinject, Typhoon, swift-dependencies)
    // For SwiftUI in the last projet I used "https://github.com/pointfreeco/swift-dependencies"
    // But for the demo project I will create dependencies manually
    let baseService: IBaseService = BaseService()
    
    func fetchMoviesList(page: Int,
                         sortBy: String,
                         handler: @escaping (MoviesListModel?) -> ()) {
        let url = URLConstructor.addParams(to: ServicesEndpoints.moviesPath,
                                           params: [.page : String(page),
                                                    .sortBy : sortBy])
        
        guard let url else {
            handler(nil)
            return
        }
        
        baseService.performRequest(with: url,
                                   type: MoviesListModel.self) { result in
            handler(result as? MoviesListModel)
        }
    }
    
    func fetchMovieDetails(id: Int,
                           handler: @escaping (MovieDetailsModel?) -> ()) {
        let url = URLConstructor.addParams(to: ServicesEndpoints.movieDetailsPath,
                                           addToPath: String(id))
        
        guard let url else {
            handler(nil)
            return
        }
        
        baseService.performRequest(with: url,
                                   type: MovieDetailsModel.self) { result in
            handler(result as? MovieDetailsModel)
        }
    }
}

extension MoviesService {
    
    enum SortBy: String {
        case popularityAsc = "popularity.asc"
        case popularityDesc = "popularity.desc"
        case revenueAsc = "revenue.asc"
        case revenueDesc = "revenue.desc"
        case primaryReleaseDateAsc = "primary_release_date.asc"
        case primaryReleaseDateDesc = "primary_release_date.desc"
        case voteAverageAsc = "vote_average.asc"
        case voteAverageDesc = "vote_average.desc"
        case voteCountAsc = "vote_count.asc"
        case voteCountDesc = "vote_count.desc"
        
        static let allCases: [SortBy] = [.popularityAsc,
                                         .popularityDesc,
                                         .revenueAsc,
                                         .revenueDesc,
                                         .primaryReleaseDateAsc,
                                         .primaryReleaseDateDesc,
                                         .voteAverageAsc,
                                         .voteAverageDesc,
                                         .voteCountAsc,
                                         .voteCountDesc]
    }
}
