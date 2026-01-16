import SwiftUI

enum MediaSegment: String, CaseIterable, Identifiable {
    case movies
    case tv
    
//    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .movies: return "Movies"
        case .tv:     return "TV"
        }
    }
    
    var id: MediaSegment { self }
}
