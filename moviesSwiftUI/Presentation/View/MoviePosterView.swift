import SwiftUI

struct MoviePosterView: View {
    let movie: Movie
    private let posterBaseURL = "https://image.tmdb.org/t/p/w342" 
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: posterURL) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "film")
                            .foregroundStyle(.secondary)
                    )
            }
            .aspectRatio(2/3, contentMode: .fit)
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
    
    private var posterURL: URL? {
        guard let path = movie.posterPath else { return nil }
        return URL(string: "\(posterBaseURL)\(path)")
    }
}
