import Foundation

protocol MovieRepository{
    func discoverMovies(page: Int) async throws -> MoviesResponse
    func discoverMoviesNextPage() async throws -> MoviesResponse
}
