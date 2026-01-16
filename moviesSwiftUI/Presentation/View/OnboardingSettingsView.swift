import SwiftUI

struct OnboardingSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appSettings: AppSettings
    @AppStorage("has_onboarded") private var hasOnboarded = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("onboarding_title")
                    .font(.largeTitle.bold())
                
                // Language
                VStack(alignment: .leading, spacing: 8) {
                    Text("onboarding_language")
                        .font(.headline)
                    HStack(spacing: 12) {
                        ForEach(AppLanguage.allCases.prefix(3)) { lang in  // Mostra 3
                            Button {
                                appSettings.languageCode = lang.rawValue
                            } label: {
                                VStack {
                                    Text(lang.flagEmoji)
                                        .font(.largeTitle)
                                    Text(lang.displayName)
                                        .font(.caption)
                                }
                                .foregroundStyle(appSettings.language == lang ? .primary : .secondary)
                            }
                        }
                    }
                }
                
                // Theme
                VStack(alignment: .leading, spacing: 8) {
                    Text("onboarding_theme")
                        .font(.headline)
                    Picker("Theme", selection: $appSettings.themeRaw) {
                        Text("theme_system").tag(AppTheme.system.rawValue)
                        Text("theme_light").tag(AppTheme.light.rawValue)
                        Text("theme_dark").tag(AppTheme.dark.rawValue)
                    }
                    .pickerStyle(.segmented)
                }
                
                Button("onboarding_continue") {
                    hasOnboarded = true
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
