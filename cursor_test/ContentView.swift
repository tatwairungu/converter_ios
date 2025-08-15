//
//  ContentView.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Use simple tab view to prevent crashes during development
        SimpleTabBarView()
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.light)
}
