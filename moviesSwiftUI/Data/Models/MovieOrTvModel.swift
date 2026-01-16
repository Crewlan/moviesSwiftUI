import Foundation

struct MovieOrTvModel: Codable{
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let firstAirDate: String?
    let title: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let originalName: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case name
    }
}
