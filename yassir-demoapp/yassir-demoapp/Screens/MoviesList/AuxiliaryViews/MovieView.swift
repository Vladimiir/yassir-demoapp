//
//  MovieView.swift
//  yassir-demoapp
//
//  Created by Vladimir Stasenko on 26.10.2023.
//

import SwiftUI

struct MovieView: View {
    
    @ObservedObject var vm: MovieViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: vm.posterUrl,
                       content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            },
                       placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            })
            .frame(width: 100, height: 150)
            
            VStack(alignment: .leading) {
                Text(vm.dataTuple.title)
                    .font(.title3)
                    .bold()
                
                Text(vm.dataTuple.date)
                    .font(.body)
                
                Spacer()
            }
        }
    }
}
