import Foundation
import SwiftUI
import Combine

enum AppLanguage: String, CaseIterable, Identifiable {
    case pt = "pt"
    case en = "en"
    case fr = "fr"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .pt: return "Português"
        case .en: return "English"
        case .fr: return "Français"
        }
    }
    
    var flagEmoji: String {
        switch self {
        case .pt: return "🇧🇷"
        case .en: return "🇺🇸"
        case .fr: return "🇫🇷"
        }
    }
    
    var flagImageName: String? {
        switch self {
        case .pt: return "flag.fill"
        default: return nil
        }
    }
}

class AppSettings: ObservableObject {
    @AppStorage("app_language") var languageCode: String = "pt"
    @AppStorage("app_theme") var themeRaw: String = "system"
    
    var language: AppLanguage {
        AppLanguage(rawValue: languageCode) ?? .pt
    }
    
    var theme: AppTheme {
        AppTheme(rawValue: themeRaw) ?? .system
    }
    
    func setLanguage(_ language: AppLanguage) {
        languageCode = language.rawValue
    }
    
    func setTheme(_ theme: AppTheme) {
        themeRaw = theme.rawValue
    }
}
