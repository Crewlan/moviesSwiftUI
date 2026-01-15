//
//  ContentView.swift
//  moviesSwiftUI
//
//  Created by Rodrigo Silva on 25/12/25.
//

import SwiftUI
import Foundation

struct RootView: View {
    @AppStorage("has_onboarded") private var hasOnboarded = false
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        if hasOnboarded {
            MoviesGridView()
        } else {
            
            OnboardingSettingsView()
        }
    }
}
