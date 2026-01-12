import Foundation

actor MovieRepositoryImpl: MovieRepository{
    enum MovieRepositoryError: Error {
        case noMorePages
    }
    private let apiService: TMDBAPIService
    private var currentPage =  1
    private var totalPages = Int.max
    
    
    init() {
        self.apiService = TMDBAPIService()
    }
    
    func discoverMovies(page: Int) async throws -> MoviesResponse {
        let response = try await apiService.discoverMovies(page: page)
        totalPages = response.totalPages
        currentPage = page + 1
        return response
    }
    
    func discoverMoviesNextPage() async throws -> MoviesResponse {
        guard currentPage <= totalPages else { throw MovieRepositoryError.noMorePages }
        return try await discoverMovies(page: currentPage)
    }
}

