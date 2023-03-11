//
//  MovieListView.swift
//  Movies
//
//  Created by Pradeep Dahiya on 20/12/2022.
//

import SwiftUI

/// The view to be able to view a list of moviesd
struct MovieListView: View {
    /// The view model backing this view
    @StateObject var viewModel: MovieListViewModel
    // @EnvironmentObject private var vmFactory: ViewModelFactory
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movies) { movie in
                    MovieCell(movie: movie)
                        .onAppear {
                            if viewModel.paginationUpdate(movie: movie) {
                                Task {
                                    await viewModel.fetchMovies()
                                }
                            }
                        }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("Popular")
        }
        .navigationViewStyle(.stack)
        .task {
            // get all movies to display in the list
            await viewModel.fetchMovies()
        }
    }
}
