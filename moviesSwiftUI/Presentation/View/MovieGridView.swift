import SwiftUI

struct MoviesGridView: View {
    @StateObject private var viewModel = MoviesGridViewModel(repository: MovieRepositoryImpl())

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.movies.isEmpty {
                    VStack(spacing: 12) {
                        ProgressView("Carregando...")
                        Text("Buscando filmes recentes")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.movies.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "film")
                            .font(.system(size: 40))
                            .foregroundStyle(.secondary)
                        Text("Nenhum filme encontrado")
                            .font(.headline)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2),
                            spacing: 16
                        ) {
                            ForEach(viewModel.movies) { movie in
                                MoviePosterView(movie: movie)
                            }
                        }
                        .padding()

                        if viewModel.isLoading {
                            ProgressView("Carregando mais...")
                                .padding()
                        }
                    }
                    .refreshable {
                        await viewModel.loadMovies()
                    }
                }
            }
            .navigationTitle("Filmes Recentes")
        }
        .task {
            await viewModel.loadMovies()
        }
    }
}
