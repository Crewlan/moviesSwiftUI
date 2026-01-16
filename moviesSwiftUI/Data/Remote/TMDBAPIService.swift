import Foundation
import FirebaseRemoteConfig

enum APIError: Error, LocalizedError {
    case missingAPIKey
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int, String)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            return "API Key não encontrada"
        case .invalidURL:
            return "URL inválida"
        case .invalidResponse:
            return "Resposta HTTP inválida"
        case .serverError(let code, let data):
            return "Servidor: \(code) - \(data.prefix(100))"
        case .decodingError(let error):
            return "Decode: \(error.localizedDescription)"
        }
    }
}

class TMDBAPIService {
    private var apiKey: String = ""
    private let baseURL = "https://api.themoviedb.org/3"
    private let session = URLSession.shared
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    init() {
        setupRemoteConfig()
    }
    
    private func setupRemoteConfig() {
#if DEBUG
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
#endif
        
        remoteConfig.setDefaults(["tmdb_api_key": "default_key" as NSString])
    }
    
    private func ensureAPIKey() async throws {
        if !apiKey.isEmpty { return }
        
        
        
        apiKey = remoteConfig.configValue(forKey: "tmdb_api_key").stringValue
        
        
        
        guard !apiKey.isEmpty else {
            throw APIError.missingAPIKey
        }
        
        
    }
    
    func discoverMovies(page: Int) async throws -> MoviesOrTvsResponse {
        try await ensureAPIKey()
        
        let base = URL(string: "\(baseURL)/discover/movie")!
        var components = URLComponents(url: base, resolvingAgainstBaseURL: true)!
        
        
        let userLanguage = AppSettings.shared.selectedLanguage
        let tmdbLanguage = mapToTMDBLanguage(userLanguage)
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "language", value: tmdbLanguage),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        components.queryItems = (components.queryItems ?? []) + queryItems
        
        guard let finalURL = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            let errorData = String(data: data, encoding: .utf8) ?? "No data"
            throw APIError.serverError(statusCode: httpResponse.statusCode, errorData)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .deferredToDate
        
        do {
            let result = try decoder.decode(MoviesOrTvsResponse.self, from: data)
            return result
        } catch {
            throw APIError.decodingError(error)
        }
    }

    
    private func mapToTMDBLanguage(_ userLanguage: String) -> String {
        switch userLanguage {
        case "pt": return "pt-BR"
        case "en": return "en-US"
        case "fr": return "fr-FR"
        default: return "en-US"
        }
    }

    
    func discoverTvs(page: Int) async throws -> MoviesOrTvsResponse {
        try await ensureAPIKey()
        
        let base = URL(string: "\(baseURL)/discover/tv")!
        var components = URLComponents(url: base, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_null_first_air_dates", value: "false"),
            URLQueryItem(name: "language", value: mapToTMDBLanguage(AppSettings.shared.selectedLanguage)),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        components.queryItems = (components.queryItems ?? []) + queryItems
        
        guard let finalURL = components.url else {
            throw APIError.invalidURL
        }
        
        
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            let errorData = String(data: data, encoding: .utf8) ?? "No data"
            throw APIError.serverError(statusCode: httpResponse.statusCode,  errorData)
        }
        
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .deferredToDate
        
        do {
            let result = try decoder.decode(MoviesOrTvsResponse.self, from: data)
            return result
        } catch {
            throw APIError.decodingError(error)
        }
        
    }
}

