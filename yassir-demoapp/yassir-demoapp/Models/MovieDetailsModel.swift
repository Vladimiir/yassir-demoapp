//
//  MovieDetailsModel.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 27.10.2023.
//

import Foundation

struct MovieDetailsModel: Codable {
    
    struct Genre: Codable, Hashable {
        let id: Int
        let name: String
    }
    
    let genres: [Genre]
    let imdbId: String
    let tagline: String
    
    enum CodingKeys: String, CodingKey {
        case genres
        case imdbId = "imdb_id"
        case tagline
    }
}
