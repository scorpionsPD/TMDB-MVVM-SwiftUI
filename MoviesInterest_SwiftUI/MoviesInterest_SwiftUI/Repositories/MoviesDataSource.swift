//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Pradeep Dahiya on 17/02/23.
//

import Foundation

protocol MoviesDataSource {
    func popular(page: Int) async throws -> MoviePaginatedList
    func details(id: Int) async throws -> Movie
}
