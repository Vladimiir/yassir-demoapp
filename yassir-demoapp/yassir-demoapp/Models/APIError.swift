//
//  APIError.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 06.02.2024.
//

import Foundation

enum APIError: Error {
    case noInternet
    case notAuthorized
    
    case parsingError
    case incorrectURL
}

// general api errors
// specific api error
// third party api errors
