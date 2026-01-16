import SwiftUI
import Foundation

struct RootView: View {
    @AppStorage("has_onboarded") private var hasOnboarded = false
    @EnvironmentObject private var appSettings: AppSettings
    @State private var selectedSegment: MediaSegment = .movies
    
    var body: some View {
        if hasOnboarded {
            mainContent
        } else {
            
            OnboardingSettingsView()
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        NavigationStack{
            VStack {
                Picker("", selection: $selectedSegment){
                    ForEach(MediaSegment.allCases){segment in
                        Text(segment.title).tag(segment)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Group{
                    switch selectedSegment {
                    case .movies:
                        MoviesGridView()
                    case .tv:
                        TvGridView()
                    }
                }
            }
        }
    }
}
