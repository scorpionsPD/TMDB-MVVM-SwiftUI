//
//  DetailViewModal.swift
//  Movies
//
//  Created by Pradeep Dahiya on 15/03/23.
//

import Foundation

@MainActor class DetailViewModal: ObservableObject {
    @Published private(set) var movie: Movie!
    private var movieRepository: MovieRepository
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    func fetchMovieDetail(_ id: Int) async {
        do {
            movie = try await movieRepository.details(id: id)
        } catch {
            print("Error fetching movie data from repository: \(error)")
        }
    }
    func formatedGenereString() -> String {
        guard let movieGenres = movie.genres else {
            return ""
        }
        let all = movieGenres.map { $0.name }
        return all.joined(separator: "/")
    }
}
