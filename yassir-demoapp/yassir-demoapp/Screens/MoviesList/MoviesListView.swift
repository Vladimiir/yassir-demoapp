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
        NavigationStack {
            VStack {
                List {
                    ForEach(vm.movies, id: \.self) { movie in
                        NavigationLink {
                            MovieDetailedView(vm: MovieDetailedViewModel(movieModel: movie))
                        } label: {
                            MovieView(vm: MovieViewModel(movieModel: movie))
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                
                // show current page and totalPages
                // show There are totalResults of movies in Database
                
                // update UI, make it more modern?
                
                Picker("Sort by...", selection: $vm.selectedSorting) {
                    ForEach(vm.sortingList, id: \.self) {
                        Text($0)
                    }
                }
                .onChange(of: vm.selectedSorting) { _, _ in
                    self.vm.sortByAction()
                }
                
                if vm.isLoadingMoreMovies {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    Button {
                        vm.loadMoreMoviesButtonAction()
                    } label: {
                        Text(vm.loadMoreMoviesTitle)
                            .font(.body)
                            .foregroundStyle(.blue)
                    }
                }
            }
            .navigationTitle("MoviesListView")
            .padding()
        }
    }
}

#Preview {
    MoviesListView()
}
