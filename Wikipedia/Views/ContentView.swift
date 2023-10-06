//
//  ContentView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/21/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var searchViewModel = ContentViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image(colorScheme == .dark ? "wiki-dark" : "wiki-light")
                    .resizable()
                    .scaledToFill()
                
                TextField(
                    "Enter text to be searched", text: $searchText,
                    onCommit: {
                        searchViewModel.getWikiRequest(for: searchText)
                    }
                ).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    Button("Search") {
                        searchViewModel.getWikiRequest(for: searchText)
                    }
                    Button("Clear") {
                        searchText = ""
                        searchViewModel.entries.removeAll()
                    }
                }
                
                List(searchViewModel.entries) { entry in
                    NavigationLink(
                        destination: WikipediaDetailView(entry: entry)
                    ) {
                        VStack(alignment: .leading) {
                            Text(entry.title)
                                .font(.headline)
                        }
                    }
                }
            }
            .onChange(of: searchText) { newValue in
                searchViewModel.getWikiRequest(for: searchText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
