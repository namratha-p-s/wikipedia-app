//
//  WikipediaDetailView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/25/23.
//

import SwiftUI

struct DetailView: View {
    @AppStorage("isDarkMode") private var darkMode = false
    
    @ObservedObject var detailViewModel = DetailViewModel()
    
    @State var entry: SearchResult
    
    var body: some View {
        ScrollView {
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
                Image(darkMode ? "wiki-dark" : "wiki-light")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct WikipediaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            entry: SearchResult(title: "Sample text"))
    }
}
