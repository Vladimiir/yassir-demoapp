//
//  MovieModel.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

struct MovieModel: Codable, Hashable {
    
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let posterPath: String?
    let releaseDate: Date?
    let title: String
    let video: Bool
    let voteAverage: Float
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        adult = ((try? container.decode(Bool.self, forKey: .adult)) != nil)
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        genreIds = try! container.decode([Int].self, forKey: .genreIds)
        id = try! container.decode(Int.self, forKey: .id)
        originalLanguage = try! container.decode(String.self, forKey: .originalLanguage)
        originalTitle = try! container.decode(String.self, forKey: .originalTitle)
        overview = try! container.decode(String.self, forKey: .overview)
        popularity = try! container.decode(Float.self, forKey: .popularity)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        releaseDate = try? container.decode(Date.self, forKey: .releaseDate)
        title = try! container.decode(String.self, forKey: .title)
        video = ((try? container.decode(Bool.self, forKey: .video)) != nil)
        voteAverage = try! container.decode(Float.self, forKey: .voteAverage)
        voteCount = try! container.decode(Int.self, forKey: .voteCount)
    }
}
