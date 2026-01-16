import SwiftUI

struct MoviePosterView: View {
    let movie: MovieOrTv
    private let posterBaseURL = "https://image.tmdb.org/t/p/w342"
    var body: some View {
        VStack(spacing: 8) {
            
            AsyncImage(url: posterURL) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle().fill(.gray.opacity(0.3))
            }
            .frame(width: 160, height: 240)  
            .clipped()
            .cornerRadius(12)
            
            
            Text(movie.title ?? movie.name ?? "")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxHeight: 44)
            
            HStack {
                Image(systemName: "star.fill").foregroundStyle(.yellow)
                Text(String(format: "%.1f", movie.voteAverage))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(height: 20)
            
            Spacer()
        }
        .frame(width: 160, height: 320)
    }
    
    private var posterURL: URL? {
        guard let path = movie.posterPath else { return nil }
        return URL(string: "\(posterBaseURL)\(path)")
    }
}
