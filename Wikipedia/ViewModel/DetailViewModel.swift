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
        Task {
            if let result = await RequestService.getWikiDetailViewData(entry: entry) {
                DispatchQueue.main.async {
                    let pages = result.query.pages
                    self.articleDescriptions = pages.values.first!
                    self.isLoaded = true
                }
            }
        }
    }
}
