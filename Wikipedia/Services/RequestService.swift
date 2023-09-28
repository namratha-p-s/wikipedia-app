//
//  WikipediaService.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/27/23.
//

import Foundation

struct RequestService {
    static func getWikiSearchData(url: URL) async -> WikipediaQuerySearch? {
        if let (data,_) = try? await URLSession.shared.data(from: url) {
            if let searchData = try? JSONDecoder().decode(WikipediaQuerySearch.self, from: data) {
                return searchData
            }
        }
        return nil
    }
    
    static func getWikiDetailViewData(url: URL) async -> WikipediaQueryPage? {
        if let (data,_) = try? await URLSession.shared.data(from: url) {
            if let searchData = try? JSONDecoder().decode(WikipediaQueryPage.self, from: data) {
                return searchData
            }
        }
        return nil
    }
}
