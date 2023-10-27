//
//  MovieDetailedViewModel.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

class MovieDetailedViewModel: ObservableObject {
    
    let movieModel: MovieModel
    
    var backdropUrl: URL? {
        ServicesEndpoints.imageUrl(with: movieModel.backdropPath)
    }
    
    var dataTuple: (title: String,
                    date: String,
                    description: String) {
        (movieModel.title,
         DatesManager.string(from: movieModel.releaseDate, with: DateFormatter.MMMyyyy),
         movieModel.overview)
    }
    
    var isImageNotAvailable: Bool {
        movieModel.backdropPath == nil
    }
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }
}
