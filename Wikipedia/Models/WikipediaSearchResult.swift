//
//  WikipediaSearchResult.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/21/23.
//

import Foundation

// Struct for the Search Result API
struct WikipediaSearchResult: Codable {
    var query: SearchQuery
}

struct SearchQuery: Codable {
    var search: [SearchResult]
}

struct SearchResult: Identifiable, Codable {
    var id: Int { return UUID().hashValue }
    var title: String
}


