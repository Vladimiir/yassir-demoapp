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
        // TODO: handle 'nil' path - show no image
        ServicesEndpoints.imageUrl(with: movieModel.backdropPath)
    }
    
    var dataTuple: (title: String,
                    date: String,
                    description: String) {
        (movieModel.title,
         movieModel.releaseDate,
         movieModel.overview)
    }
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }
}
