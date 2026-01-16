import SwiftUI

struct TvGridView: View {
    @StateObject private var viewModel = TvGridViewModel(repository: TvRepositoryImpl())
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.tvShows.isEmpty {
                    VStack(spacing: 12) {
                        ProgressView("Carregando...")
                        Text("Buscando shows de tv recentes")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.tvShows.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "film")
                            .font(.system(size: 40))
                            .foregroundStyle(.secondary)
                        Text("Nenhum programa de tv encontrado")
                            .font(.headline)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.fixed(160), spacing: 16), count: 2),
                            spacing: 16
                        ) {
                            ForEach(viewModel.tvShows) { tvShows in
                                MoviePosterView(movie: tvShows)
                            }
                        }
                        .padding()
                        
                        if viewModel.isLoading {
                            ProgressView("Carregando mais...")
                                .padding()
                        }
                    }
                    .refreshable {
                        await viewModel.fetchTvShows()
                    }
                }
            }
            .navigationTitle("Shows de TV Recentes")
        }
        .task {
            await viewModel.fetchTvShows()
        }
    }
}
