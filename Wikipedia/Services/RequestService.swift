//
//  WikipediaService.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/27/23.
//

import Foundation

struct RequestService {
    
    static var wikiURL = "https://en.wikipedia.org/w/api.php?action=query&format=json"
    
    // This generic function will call the required API in order to fetch the required JSON response
    static func fetchData<T: Decodable>(from url: URL) async -> T? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
    
    // This function encodes the search key input to be passed as a paramter to the API call to retrieve the title
    static func getWikiSearchData(searchText: String) async -> WikipediaQuerySearch? {
        let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "\(wikiURL)&list=search&srsearch=\(encodedSearchText)&srlimit=5") else {
            return nil
        }
        URLSession.shared.invalidateAndCancel()
        return await fetchData(from: url)
    }
    
    // This function encodes the particular entry(title) selected as a paramter to the API call to retrieve the description and image
    static func getWikiDetailViewData(entry: SearchResult) async -> WikipediaQueryPage? {
        let encodedQuery = "&prop=extracts|pageimages&exintro=1&explaintext=1&titles=\(entry.title)&piprop=thumbnail&pithumbsize=200".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: "\(wikiURL)\(encodedQuery)") else {
            return nil
        }
        URLSession.shared.invalidateAndCancel()
        return await fetchData(from: url)
    }
}

