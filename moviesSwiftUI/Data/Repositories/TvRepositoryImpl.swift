import Foundation

actor TvRepositoryImpl: TvRepository {
    enum TvRepositoryError: Error {
        case noMorePages
    }
    
    private let apiService: TMDBAPIService
    private var currentPage: Int = 1
    private var totalPages = Int.max
    
    
    init() {
        self.apiService = TMDBAPIService()
    }
    
    func discoverTv(page: Int) async throws -> MoviesOrTvsResponse {
        let response = try await apiService.discoverTvs(page: page)
        totalPages = response.totalPages
        currentPage = page + 1
        return response
    }
    
    func discoverMoreTv() async throws -> MoviesOrTvsResponse {
        guard currentPage <= totalPages else {
            throw TvRepositoryError.noMorePages
        }
        return try await discoverTv(page: currentPage)
    }
}
