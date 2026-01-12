import Foundation
import Combine
import FirebaseRemoteConfig

@MainActor
final class RemoteConfigViewModel: ObservableObject {
    @Published var welcomeText: String = ""
    
    private let remoteConfig: RemoteConfig
    
    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        
        
        let defaults: [String: NSObject] = [
            "tmdb_api_key": "" as NSString
        ]
        remoteConfig.setDefaults(defaults)
        
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        Task { await fetchAndActivate() }
    }
    
    func fetchAndActivate() async {
        do {
            _ = try await remoteConfig.fetchAndActivate()
            let value = remoteConfig.configValue(forKey: "tmdb_api_key").stringValue
            self.welcomeText = value
        } catch {
            
            let value = remoteConfig.configValue(forKey: "tmdb_api_key").stringValue
            self.welcomeText = value
        }
    }
}

