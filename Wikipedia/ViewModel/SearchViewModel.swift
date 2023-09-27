//
//  WikipediaHelper.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/27/23.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var entries = [SearchResult]()
    @Published var articleDescriptions = [String: String]()
    @Published public var searchText = ""
    
    func getWikiRequest(for searchText: String) async {
        isEmpty()
        let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string:"https://en.wikipedia.org/w/api.php?action=query&format=json&list=search&srsearch=\(encodedSearchText)&srlimit=5")!
        
        if let result = await RequestService.getWikiSearchData(url: url) {
            entries = result.query.search.map { searchResult in
                return SearchResult(
                    title: searchResult.title)
            }
            
            for entry in entries {
                let articleTitle = entry.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                
                let url = URL(
                    string: "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&exintro=1&explaintext=1&titles=\(articleTitle)")!
                if let result = await RequestService.getWikiDetailViewData(url: url) {
                    if let page = result.query.pages.first?.value {
                        articleDescriptions[entry.title] = page.extract
                    }
                }
            }
        }
    }
    
    private func isEmpty() {
        if searchText.isEmpty {
            entries.removeAll()
            articleDescriptions.removeAll()
            return
        }
    }
}

