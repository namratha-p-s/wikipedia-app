//
//  DetailViewModel.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/28/23.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var articleDescriptions: Page? = nil
    @Published var isLoaded = false
    
    var wikiURL = "https://en.wikipedia.org/w/api.php?"
    
    func getWikiDetailsRequest(entry: SearchResult) {
        let encodedQuery = "action=query&format=json&prop=extracts|pageimages&exintro=1&explaintext=1&titles=\(entry.title)&piprop=thumbnail&pithumbsize=200".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: "\(wikiURL)\(encodedQuery)") else {
            return
        }
        
        Task {
            if let result = await RequestService.getWikiDetailViewData(url: url) {
                DispatchQueue.main.async {
                    let pages = result.query.pages
                    self.articleDescriptions = pages.values.first!
                    self.isLoaded = true
                }
            }
        }
    }
}
