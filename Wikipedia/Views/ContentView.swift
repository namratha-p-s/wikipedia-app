//
//  ContentView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/21/23.
//

import SwiftUI

struct ContentView: View {
    @State var entries = [WikipediaSearchResult.Query.SearchResult]()
    @State var articleDescriptions = [String: String]()
    @State var searchText = ""
    
    func getWikipediaData() async {
        do {
            // Text field empty implies to remove all the entries
            if searchText.isEmpty {
                entries.removeAll()
                articleDescriptions.removeAll()
                return
            }
            
            // Text field can have spaces, hence adding % for spaces
            let encodedSearchText =
            searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            // Retreiving only the top 5 entries of the API response
            let url = URL(
                string:
                    "https://en.wikipedia.org/w/api.php?action=query&format=json&list=search&srsearch=\(encodedSearchText)&srlimit=5"
            )!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let result = try JSONDecoder().decode(WikipediaSearchResult.self, from: data)
            
            // All the 5 entries with respect to the keyword provided in the Text Field is stored in an array with their titles
            entries = result.query.search.map { searchResult in
                return WikipediaSearchResult.Query.SearchResult(
                    title: searchResult.title)
            }
            
            // To retrieve the description of the top 5 entries, we need to call another Wikipedia API
            for entry in entries {
                let articleTitle = entry.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                
                let articleURLString =
                "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&exintro=1&explaintext=1&titles=\(articleTitle)"
                
                let articleURL = URL(string: articleURLString)!
                
                let (articleData, _) = try await URLSession.shared.data(from: articleURL)
                
                let articleResult = try JSONDecoder().decode(WikipediaArticle.self, from: articleData)
                
                // Store the description of a particular entry to its respective title
                if let page = articleResult.query.pages.first?.value {
                    articleDescriptions[entry.title] = page.extract
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(
                    "Enter text to be searched", text: $searchText,
                    onCommit: {
                        Task {
                            await getWikipediaData()
                        }
                    }
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                HStack {
                    Button("Search") {
                        Task {
                            await getWikipediaData()
                        }
                    }
                    Button("Clear") {
                        searchText = ""
                        entries.removeAll()
                    }
                }
                
                List(entries) { entry in
                    NavigationLink(
                        destination: WikipediaDetailView(
                            entry: entry, description: articleDescriptions[entry.title] ?? "")
                    ) {
                        VStack(alignment: .leading) {
                            Text(entry.title)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationBarTitle("Wikipedia")
            .onChange(of: searchText) { newValue in
                Task {
                    await getWikipediaData()
                }
            }
        }
    }
}

struct WikipediaDetailView: View {
    let entry: WikipediaSearchResult.Query.SearchResult
    let description: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text(entry.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text(description)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
