extension Movie {
    init(from tmdbMovie: Movie) {
        self.id = tmdbMovie.id
        self.title = tmdbMovie.title
        self.overview = tmdbMovie.overview
        self.posterPath = tmdbMovie.posterPath
        self.voteCount = tmdbMovie.voteCount
        self.voteAverage = tmdbMovie.voteAverage
        self.adult = tmdbMovie.adult
        self.backdropPath = tmdbMovie.backdropPath
        self.originalTitle = tmdbMovie.originalTitle
        self.originalLanguage = tmdbMovie.originalLanguage
        self.popularity = tmdbMovie.popularity
        self.releaseDate = tmdbMovie.releaseDate
        self.video = tmdbMovie.video
    }
    
}
