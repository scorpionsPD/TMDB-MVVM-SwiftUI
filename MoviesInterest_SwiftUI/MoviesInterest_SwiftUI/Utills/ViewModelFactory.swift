//
//  ViewModelFactory.swift
//  MoviesInterest_SwiftUI
//
//  Created by Pradeep Dahiya on 07/03/23.
//

import Foundation

private let tmdbAPIKey = ApiKeyStore.theMovieDbKey
/// Factory class responsible for constructing view models
class ViewModelFactory: ObservableObject {
    private let movieDBService = TheMovieDbService(apiKey: tmdbAPIKey)
    /// Creates a view model for movie list
    /// - Returns: a fresh instance of a MovieListViewModel
    @MainActor func makeMovieListVM() -> MovieListViewModel {
        return MovieListViewModel(
            movieRepository: MovieRepository(service: movieDBService)
        )
    }
}
