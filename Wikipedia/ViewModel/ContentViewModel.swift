//
//  WikipediaHelper.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/27/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var entries = [SearchResult]()
    
    // This function will retrieve the top 5 titles associated with the search key input
    func getWikiRequest(for searchText: String) {
        if searchText.isEmpty {
            entries.removeAll()
            return
        }
        
        Task {
            if let result = await RequestService.getWikiSearchData(searchText: searchText) {
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
