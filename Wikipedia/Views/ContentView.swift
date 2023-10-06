//
//  ContentView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/21/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Home", systemImage: "heart.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
