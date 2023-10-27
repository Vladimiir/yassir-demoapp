//
//  MovieViewModel.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

class MovieViewModel: ObservableObject {
    
    let movieModel: MovieModel
    
    var dataTuple: (title: String, 
                    date: String) {
        (movieModel.title,
         DatesManager.string(from: movieModel.releaseDate, with: DateFormatter.MMMyyyy))
    }
    
    var posterUrl: URL? {
        ServicesEndpoints.imageUrl(with: movieModel.posterPath)
    }
    
    var isImageNotAvailable: Bool {
        movieModel.posterPath == nil
    }
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }
}
