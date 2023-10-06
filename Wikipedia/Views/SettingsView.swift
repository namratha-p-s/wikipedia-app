//
//  SettingsView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 10/5/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
}
