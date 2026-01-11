import Foundation
import Combine
import FirebaseRemoteConfig

@MainActor
final class RemoteConfigViewModel: ObservableObject {
    @Published var welcomeText: String = "Carregando…"

    private let remoteConfig: RemoteConfig

    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()

        // Defaults locais para chaves esperadas
        let defaults: [String: NSObject] = [
            "tmdb_api_key": "" as NSString
        ]
        remoteConfig.setDefaults(defaults)

        // Em dev, buscar sempre que possível
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        Task { await fetchAndActivate() }
    }

    func fetchAndActivate() async {
        do {
            _ = try await remoteConfig.fetchAndActivate()
            let value = remoteConfig.configValue(forKey: "tmdb_api_key").stringValue ?? ""
            self.welcomeText = value
        } catch {
            // Em caso de erro, use default/local
            let value = remoteConfig.configValue(forKey: "tmdb_api_key").stringValue ?? ""
            self.welcomeText = value
        }
    }
}

