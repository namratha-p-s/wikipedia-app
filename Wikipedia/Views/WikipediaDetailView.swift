//
//  WikipediaDetailView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/25/23.
//

import SwiftUI

struct WikipediaDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    let entry: SearchResult
    let description: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text(entry.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(10)
                Text(description)
                    .padding()
            }
        }.toolbar {
            Image(colorScheme == .dark ? "wiki-dark" : "wiki-light")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
    }
}

struct WikipediaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WikipediaDetailView(entry: SearchResult(title: "Sample"), description: "")
    }
}
