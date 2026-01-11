//
//  ContentView.swift
//  moviesSwiftUI
//
//  Created by Rodrigo Silva on 25/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var rcViewModel = RemoteConfigViewModel()

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text(rcViewModel.welcomeText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Recarregar Remote Config") {
                Task { await rcViewModel.fetchAndActivate() }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
