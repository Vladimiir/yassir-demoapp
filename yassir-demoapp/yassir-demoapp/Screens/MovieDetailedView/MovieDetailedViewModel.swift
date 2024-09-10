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
        var imdbUrl: URL?

        if let imdbId = details?.imdbId {
            imdbUrl = URL(string: "https://www.imdb.com/title/\(imdbId)")
        }

        return ("Show in IMDB", imdbUrl)
    }

    var detailsTuple: (tagline: String,
                       genres: [MovieDetailsModel.Genre]) {
        (details?.tagline ?? "",
         details?.genres ?? [])
    }

    var errorAPI: Error?

    var dataTuple: (title: String,
                    date: String,
                    description: String) {
        (movieModel.title ?? "",
         DatesManager.string(from: movieModel.releaseDate, with: DateFormatter.MMMyyyy),
         movieModel.overview ?? "")
    }

    var isImageNotAvailable: Bool {
        movieModel.backdropPath == nil
    }

    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }

    func onAppearEvent() {
        guard let id = movieModel.id else {
            // We can show an error here
            return
        }

        moviesService.fetchMovieDetails(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let details):
                    self.details = details
                case .failure(let error):
                    self.errorAPI = error
                }
            }
        }
    }
}
