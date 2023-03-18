//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Pradeep Dahiya on 20/12/2022.
//

import Foundation

/// The view model backing the movie list
@MainActor class MovieListViewModel: ObservableObject {
    @Published private(set) var movies: [Movie] = []
    private var movieRepository: MovieRepository
    /// whether there are more movies available to fetch
    private var availableMovies = true
    private var nextPage = 1
    /// Create a view model with the logic to provide a list of movies, with pagination.
    /// - Parameters:
    ///   - movieRepository: repository to get movie information
    ///   - type: the type of movie list
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    /// fetch the next page of movies
    func fetchMovies() async {
        if availableMovies {
            do {
                let paginatedMovies: MoviePaginatedList = try await movieRepository.popular(page: nextPage)
                nextPage = paginatedMovies.page + 1
                availableMovies = nextPage <= paginatedMovies.totalPages
                self.movies.append(contentsOf: paginatedMovies.results)
            } catch {
                print("Error fetching movie data from repository: \(error)")
            }
        }
    }
    /// Determine whether more movies should be fetched with the intention
    /// of fetching more movies ahead of time before last movie is accessed
    /// - Parameter movie: the movie to check location in list
    func paginationUpdate(movie: Movie) -> Bool {
        // check if user is starting to view the last 3 movies to fetch new movies ahead of time
        guard movies.suffix(3).contains(movie) else {
            print("pagination update - not last 3 items")
            return false
        }
        print("pagination update - getting next page of movies")
        return true
    }
}
