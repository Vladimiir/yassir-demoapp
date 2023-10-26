//
//  MoviesListView.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import SwiftUI

struct MoviesListView: View {
    
    @StateObject var vm = MoviesListViewModel()
    
    var body: some View {
        VStack {
            Text("MoviesListView")
                .font(.title)
                .padding(.bottom, 20)
            
            List {
                ForEach(vm.movies, id: \.self) { movie in
                    // TODO: use a cell instead
                    Text(movie.title)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)

            // show current page and totalPages
            // show There are totalResults of movies in Database
            
            Button {
                vm.loadMoreMoviesButtonAction()
            } label: {
                Text(vm.loadMoreMoviesTitle)
                    .font(.body)
                    .foregroundStyle(.blue)
            }
        }
        .padding()
    }
}

// List of movies
    // Detailed info view
// AuthenticationService
// MoviesService

// Write some unit tests

#Preview {
    MoviesListView()
}
