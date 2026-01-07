struct MovieList: Equatable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]
}
