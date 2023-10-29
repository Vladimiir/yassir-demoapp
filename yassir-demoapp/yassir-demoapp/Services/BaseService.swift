//
//  BaseService.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 27.10.2023.
//

import Foundation

protocol IBaseService {
    
    /// Perform url with specified paramenters
    func performRequest<Response: Decodable>(with url: URL,
                                             type: Response.Type,
                                             handler: @escaping (Response?) -> ())
}

class BaseService: ObservableObject, IBaseService {
    
    func performRequest<Response: Decodable>(with url: URL,
                                             type: Response.Type,
                                             handler: @escaping (Response?) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(ServicesEndpoints.apiReadAccessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)
                
                if let result = try? decoder.decode(type, from: data) {
                    handler(result)
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
