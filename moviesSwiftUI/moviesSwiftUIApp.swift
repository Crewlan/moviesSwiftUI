//
//  moviesSwiftUIApp.swift
//  moviesSwiftUI
//
//  Created by Rodrigo Silva on 25/12/25.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct moviesSwiftUIApp: App {
    
    @StateObject private var appSettings = AppSettings()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appSettings)
                .environment(\.locale, Locale(identifier: appSettings.languageCode))
                .preferredColorScheme(colorScheme)
        }
    }
    
    private var colorScheme: ColorScheme? {
        switch appSettings.theme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}


