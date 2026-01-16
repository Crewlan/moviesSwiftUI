import Foundation

struct MoviesOrTvsResponse: Codable {
    let results: [MovieOrTv]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}
