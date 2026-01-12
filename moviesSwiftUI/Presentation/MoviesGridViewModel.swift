import Foundation
import SwiftUI
import Combine

@MainActor
class MoviesGridViewModel: ObservableObject {
    @Published var movies: [Movie] = []  
    @Published var isLoading = false
    @Published var hasMoreData = true
    
    private let repository: MovieRepository
    private var currentPage = 1
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func loadMovies() async {
        
        guard !isLoading && hasMoreData else { return }
        
        isLoading = true
        
        
        do {
            let response = try await repository.discoverMoviesNextPage()
        
            
            movies.append(contentsOf: response.results.map { Movie(from: $0) })
        
            
            if response.results.isEmpty {
                hasMoreData = false
        
            }
            currentPage += 1
        } catch {
        
        }
        
        isLoading = false
     
    }

}
