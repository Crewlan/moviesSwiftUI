import Foundation

protocol TvRepository {
    func discoverTv(page: Int) async throws -> MoviesOrTvsResponse
    func discoverMoreTv() async throws -> MoviesOrTvsResponse
}
