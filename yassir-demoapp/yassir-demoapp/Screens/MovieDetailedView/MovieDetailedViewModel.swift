//
//  MovieDetailedViewModel.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import Foundation

class MovieDetailedViewModel: ObservableObject {
    
    let movieModel: MovieModel
    
    // Mostly for assigning values I prefer to use DI (Swinject, Typhoon, swift-dependencies)
    // For SwiftUI in the last projet I used "https://github.com/pointfreeco/swift-dependencies"
    // But for the demo project I will create dependencies manually
    private var moviesService: IMoviesService = MoviesService()

    @Published var details: MovieDetailsModel?
    
    var backdropUrl: URL? {
        URLConstructor.imageUrl(with: movieModel.backdropPath)
    }
    
    var imdbTuple: (title: String,
                    url: URL?) {
        ("Show in IMDB",
         URL(string: "https://www.imdb.com/title/\(details?.imdbId ?? "")"))
    }
    
    var detailsTuple: (tagline: String,
                       genres: [MovieDetailsModel.Genre]) {
        (details?.tagline ?? "",
         details?.genres ?? [])
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
    
    func onAppearEvent() {
        moviesService.fetchMovieDetails(id: movieModel.id) { details in
            DispatchQueue.main.async {
                self.details = details
            }
        }
    }
}
