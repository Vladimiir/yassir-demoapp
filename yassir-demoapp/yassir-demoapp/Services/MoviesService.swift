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
}

class MoviesService: ObservableObject, IMoviesService {
    
    func fetchMoviesList(page: Int,
                         sortBy: String,
                         handler: @escaping (MoviesListModel?) -> ()) {
        let url = URLConstructor.addParams(params: [.page : String(page),
                                                    .sortBy : sortBy],
                                           for: ServicesEndpoints.moviesPath)
        
        guard let url else {
            handler(nil)
            return
        }
        
        // TODO: move it to a base service to perform requests there without writing it everytime
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(ServicesEndpoints.apiReadAccessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)
                
                if let movies = try? decoder.decode(MoviesListModel.self, from: data) {
                    handler(movies)
                } else if let errorModel = try? JSONDecoder().decode(MoviesListErrorModel.self, from: data) {
                    print(errorModel)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
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
