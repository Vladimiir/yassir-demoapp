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
            
            VStack(alignment: .leading) {
                Text(vm.dataTuple.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                Text(vm.dataTuple.date)
                    .font(.body)
                    .padding(.bottom, 10)
                
                Text(vm.dataTuple.description)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
