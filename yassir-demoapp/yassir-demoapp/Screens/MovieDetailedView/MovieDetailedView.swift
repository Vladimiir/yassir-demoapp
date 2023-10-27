//
//  MovieDetailedView.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import SwiftUI

struct MovieDetailedView: View {
    
    @ObservedObject var vm: MovieDetailedViewModel
    
    var body: some View {
        ScrollView {
            if vm.isImageNotAvailable {
                Image("NoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                AsyncImage(url: vm.backdropUrl,
                           content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                },
                           placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                })
            }
            
            VStack(alignment: .leading) {
                Text(vm.dataTuple.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                Text(vm.detailsTuple.tagline)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                
                // Genres
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(vm.detailsTuple.genres, id: \.self) { genre in
                            Text(genre.name)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 8)
                                .background(
                                    Capsule()
                                        .fill(.purple)
                                )
                                .padding(.bottom, 10)
                        }
                    }
                }
                
                Text(vm.dataTuple.date)
                    .font(.body)
                    .padding(.bottom, 10)
                
                Text(vm.dataTuple.description)
                    .font(.body)
                    .padding(.bottom, 20)
                
                if let url = vm.imdbTuple.url {
                    HStack(alignment: .center) {
                        Link(destination: url) {
                            Text(vm.imdbTuple.title)
                                .font(.title)
                                .foregroundStyle(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(
                                    Capsule()
                                        .fill(.blue)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .onAppear {
            vm.onAppearEvent()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
