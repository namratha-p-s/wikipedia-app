//
//  WikipediaDetailView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/25/23.
//

import SwiftUI

struct WikipediaDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var detailViewModel = DetailViewModel()
    
    @State var entry: SearchResult
    
    var body: some View {
            VStack {
                if detailViewModel.isLoaded {
                    if detailViewModel.articleDescriptions?.thumbnail != nil {
                        AsyncImage(url: URL(string: detailViewModel.articleDescriptions!.thumbnail!.source))
                    } else {
                        Image(systemName: "photo")
                    }
                    
                    Text(detailViewModel.articleDescriptions!.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(10)
                    
                    Text(detailViewModel.articleDescriptions!.extract)
                        .padding()
                }
                else {
                    ProgressView()
                }
            }
            .onAppear {
                detailViewModel.getWikiDetailsRequest(entry: entry)
            }.toolbar {
            Image(colorScheme == .dark ? "wiki-dark" : "wiki-light")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
    }
}

struct WikipediaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WikipediaDetailView(
            entry: SearchResult(title: "Sample text"))
    }
}
