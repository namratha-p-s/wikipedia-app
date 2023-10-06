//
//  SearchView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 10/5/23.
//

import SwiftUI

struct SearchView: View {
    @AppStorage("isDarkMode") private var darkMode = false
    
    @ObservedObject var searchViewModel = ContentViewModel()
    
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image(darkMode ? "wiki-dark" : "wiki-light")
                    .resizable()
                    .scaledToFill()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                
                HStack {
                    TextField(
                        "Enter text to be searched", text: $searchText
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                            searchViewModel.entries.removeAll()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.medium)
                        }
                        .padding(.trailing)
                    }
                    
                    Button(action: {
                        searchViewModel.getWikiRequest(for: searchText)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.medium)
                    }
                    .padding(.trailing)
                }
                
                List(searchViewModel.entries) { entry in
                    NavigationLink(
                        destination: DetailView(entry: entry)
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

#Preview {
    SearchView()
}
