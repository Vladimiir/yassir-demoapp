//
//  MoviesService.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

class MoviesService: ObservableObject {
    
    func fetchMoviesList(handler: @escaping ([MovieModel]) -> ()){
        guard let url = ServicesEndpoints.moviesUrl else {
            // TODO: show an error?
            handler([])
            return
        }
        
        Task {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(ServicesEndpoints.apiKey)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let (data, _) = try await URLSession.shared.data(for: request)

                if let movies = try? JSONDecoder().decode([MovieModel].self, from: data) {
                    print(movies)
                    handler(movies)
                } else {
                    print("Invalid Response")
                }
            } catch {
                print("Failed to Send POST Request \(error)")
            }
        }
    }
}
