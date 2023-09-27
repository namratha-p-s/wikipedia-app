//
//  WikipediaService.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/27/23.
//

import Foundation

struct RequestService {
    static func getWikiSearchData(url: URL) async -> WikipediaSearchResult? {
        if let (data,_) = try? await URLSession.shared.data(from: url) {
            if let searchData = try? JSONDecoder().decode(WikipediaSearchResult.self, from: data) {
                return searchData
            }
        }
        return nil
    }
    
    static func getWikiDetailViewData(url: URL) async -> WikipediaArticle? {
        if let (data,_) = try? await URLSession.shared.data(from: url) {
            if let searchData = try? JSONDecoder().decode(WikipediaArticle.self, from: data) {
                return searchData
            }
        }
        return nil
    }
}
