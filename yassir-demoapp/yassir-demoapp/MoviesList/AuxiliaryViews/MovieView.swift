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
                    .background(Color.green)
            },
                       placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            })
            .frame(width: 100, height: 150)
            .background(Color.red)
            
            VStack(alignment: .leading) {
                Text(vm.dataTuple.title)
                    .font(.title3)
                    .bold()
                    .background(Color.gray)
                
                Text(vm.dataTuple.date)
                    .font(.body)
                    .background(Color.brown)
                
                Spacer()
            }
            .background(Color.blue)
        }
        .background(Color.red)
    }
}
