//
//  MoviesService.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

// TODO: use protocol
class MoviesService: ObservableObject {
    
    func fetchMoviesList(page: Int,
                         sortBy: String,
                         handler: @escaping (MoviesListModel) -> ()){
        // TODO: replace it with 'addParam' func from the service
        var moviesPath = ServicesEndpoints.moviesPath
        moviesPath.append("?page=\(page)")
        moviesPath.append("&sort_by=\(sortBy)")
        
        guard let url = URL(string: moviesPath) else {
            // TODO: show an error?
            handler(.init(page: 0, results: [], totalPages: 0, totalResults: 0))
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
                
                if let movies = try? JSONDecoder().decode(MoviesListModel.self, from: data) {
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
