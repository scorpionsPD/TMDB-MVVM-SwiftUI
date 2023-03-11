//
//  MovieRepository.swift
//  Movies
//
//  Created by Pradeep Dahiya on 19/12/2022.
//

import Foundation

/// A repository for handling all requests relating to movies
class MovieRepository: MoviesDataSource {
    private var service: RESTService
    /// Initialises the movie repository with a service to get the relevant movie information
    /// - Parameter service: the service providing movie information
    init(service: RESTService) {
        self.service = service
    }
    /// Get a list of the current popular movies
    /// - Parameter page: page to fetch - defaults to 1
    /// - Returns: paginated list of movies
    func popular(page: Int) async throws -> MoviePaginatedList {
        try await service.get(endpoint: MoviesEndpoint.popular(page: page))
    }
    /// Get a list of upcoming movies in theatres
    /// - Parameter page: page to fetch - defaults to 1
    /// - Returns: paginated list of movies
    func upcoming(page: Int) async throws -> MoviePaginatedList {
        try await service.get(endpoint: MoviesEndpoint.upcoming(page: page))
    }
    /// Get a details of  selected movie in theatres
    /// - Parameter id: id of a perticular movie
    /// - Returns: movie modal
    func details(id: Int) async throws -> Movie {
        try await service.get(endpoint: MoviesEndpoint.details(id: id))
    }
}
