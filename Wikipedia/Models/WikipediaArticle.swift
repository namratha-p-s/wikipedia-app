//
//  WikipediaArticle.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/21/23.
//

import Foundation

// Struct for the desricption of a particular Search Result API
struct WikipediaArticle: Codable {
    var query: ArticleQuery
}

struct ArticleQuery: Codable {
    var pages: [String: Page]
}

struct Page: Codable {
    var title: String
    var extract: String
}

