//
//  WikipediaArticle.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/21/23.
//

import Foundation

// Struct for the desricption of a particular Search Result API
struct WikipediaQueryPage: Codable {
    var query: PageQuery
}

struct PageQuery: Codable {
    var pages: [String: Page]
}

struct Page: Identifiable, Codable {
    var id: Int { return UUID().hashValue }
    var title: String
    var extract: String
    var thumbnail: Thumbnail?
}

struct Thumbnail: Codable {
    var source: String
}
