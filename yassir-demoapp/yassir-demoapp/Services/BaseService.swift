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
                                             handler: @escaping (Result<Response, Error>) -> ())
}

class BaseService: IBaseService {

    func performRequest<Response: Decodable>(with url: URL,
                                             type: Response.Type,
                                             handler: @escaping (Result<Response, Error>) -> ()) {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 5

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(ServicesEndpoints.apiReadAccessToken)",
                         forHTTPHeaderField: "Authorization")
        request.setValue("application/json", 
                         forHTTPHeaderField: "Content-Type")

        let task = URLSession(configuration: config).dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)

                if let result = try? decoder.decode(type, from: data) {
                    handler(.success(result))
                } else {
                    handler(.failure(APIError.parsingError))
                }
            } else if let error = error {
                if let urlError = error as? URLError {
                    if urlError.code == URLError.notConnectedToInternet {
                        handler(.failure(APIError.noInternet))
                    } else if urlError.code == URLError.userAuthenticationRequired {
                        handler(.failure(APIError.notAuthorized))
                    } else if urlError.code == URLError.timedOut {
                        handler(.failure(APIError.noInternet))
                    } else {
                        handler(.failure(urlError))
                    }
                } else {
                    handler(.failure(error))
                }
            }
        }

        task.resume()
    }
}
