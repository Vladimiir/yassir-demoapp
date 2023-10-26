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
         movieModel.releaseDate)
    }
    
    var posterUrl: URL? {
        // TODO: handle 'nil' path - show no image
        ServicesEndpoints.imageUrl(with: movieModel.posterPath)
    }
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }
}
