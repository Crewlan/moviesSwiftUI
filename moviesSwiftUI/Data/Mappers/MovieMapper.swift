extension MovieOrTv {
    init(from tmdbMovie: MovieOrTv) {
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
        self.originalName = tmdbMovie.originalName
        self.firstAirDate = tmdbMovie.firstAirDate
        self.name = tmdbMovie.name
    }
    
}
