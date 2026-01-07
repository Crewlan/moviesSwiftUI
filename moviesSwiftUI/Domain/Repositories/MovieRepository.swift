protocol MovieRepository {
    func fetchPopular(page: Int) async throws -> MovieList
    func search(query: String, page: Int) async throws -> MovieList
    func fetchTopRated(page: Int) async throws -> MovieList
    func toggleFavorite(movie: Movie) async throws -> Movie
    func getFavorites() async throws -> [Movie]
}
