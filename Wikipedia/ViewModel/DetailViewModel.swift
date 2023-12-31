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
    
    // This function will retrieve the search result for a particular entry
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
