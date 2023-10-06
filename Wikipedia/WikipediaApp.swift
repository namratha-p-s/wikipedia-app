//
//  WikipediaApp.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 9/21/23.
//

import SwiftUI

@main
struct WikipediaApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
