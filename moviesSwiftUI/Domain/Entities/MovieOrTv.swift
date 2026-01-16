import Foundation

struct MovieOrTv: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let originalLanguage, overview: String
    let originalTitle: String?
    let originalName: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let firstAirDate: String?
    let name: String?
}

