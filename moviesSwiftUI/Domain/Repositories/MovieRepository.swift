import Foundation

protocol MovieRepository{
    func discoverMovies(page: Int) async throws -> MoviesOrTvsResponse
    func discoverMoviesNextPage() async throws -> MoviesOrTvsResponse
}
