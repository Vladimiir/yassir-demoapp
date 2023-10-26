//
//  MoviesService.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

class MoviesService: ObservableObject {
    
    func fetchMoviesList(page: Int,
                         handler: @escaping (MoviesListModel) -> ()){
        var moviesPath = ServicesEndpoints.moviesPath
        moviesPath.append("?page=\(page)")
        
        guard let url = URL(string: moviesPath) else {
            // TODO: show an error?
            handler(.init(page: 0, results: [], totalPages: 0, totalResults: 0))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(ServicesEndpoints.apiReadAccessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
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
