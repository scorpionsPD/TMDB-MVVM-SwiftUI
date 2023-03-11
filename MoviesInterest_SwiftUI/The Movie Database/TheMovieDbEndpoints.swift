//
//  TheMovieDbEndpoints.swift
//  Movies
//
//  Created by Pradeep Dahiya on 16/09/2022.
//

import Foundation

/// Movie API Endpoints
enum MoviesEndpoint {
    case popular(page: Int? = nil)
    case upcoming(page: Int? = nil)
    case details(id: Int? = nil)
}

extension MoviesEndpoint: Endpoint {
    private static let basePath = URL(string: "/movie")!
    var url: URL {
        switch self {
        case .popular(let page):
            return Self.basePath
                .appendingPathComponent("popular")
                .appendingPage(page)
        case .upcoming(let page):
            return Self.basePath
                .appendingPathComponent("upcoming")
                .appendingPage(page)
        case .details(let id):
            return Self.basePath
                .appendingPathComponent("/\(id ?? 0)")
        }
    }
}
