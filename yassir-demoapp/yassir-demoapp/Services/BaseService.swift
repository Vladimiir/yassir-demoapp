//
//  BaseService.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 27.10.2023.
//

import Foundation

protocol IBaseService {
    
}

class BaseService: ObservableObject, IBaseService {
    
    func performRequest(handler: @escaping (MoviesListModel?) -> ()) {
        guard let url = URL(string: moviesPath) else {
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
