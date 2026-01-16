import Foundation
import SwiftUI
import Combine

@MainActor
class TvGridViewModel: ObservableObject {
    @Published var tvShows: [MovieOrTv] = []
    @Published var isLoading = false
    @Published var hasMoreData = true
    
    
    
    private let tvRepository: TvRepository
    private var currentPage = 1
    
    init(repository: TvRepository){
        self.tvRepository = repository
    }
    
    func fetchTvShows() async {
        guard !isLoading && hasMoreData else { return }
        
        isLoading = true
        
        do {
            let response = try await tvRepository.discoverMoreTv()
            
            tvShows.append(contentsOf: response.results.map{MovieOrTv(from: $0) })
            
            if response.results.isEmpty {
                hasMoreData = false
            }
            currentPage += 1
            
        } catch {
            
        }
        isLoading = false
    }
    
}
