//
//  WikipediaHelper.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/27/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var entries = [SearchResult]()
    var wikiURL = "https://en.wikipedia.org/w/api.php?action=query&format=json"
    
    func getWikiRequest(for searchText: String) {
        if searchText.isEmpty {
            entries.removeAll()
            return
        }
        
        let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "\(wikiURL)&list=search&srsearch=\(encodedSearchText)&srlimit=5") else {
            return
        }
        
        Task {
            if let result = await RequestService.getWikiSearchData(url: url) {
                DispatchQueue.main.async {
                    self.entries = result.query.search.map { searchResult in
                        return SearchResult(
                            title: searchResult.title
                        )
                    }
                }
            }
        }
    }
}
