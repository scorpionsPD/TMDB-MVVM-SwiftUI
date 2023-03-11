//
//  MoviesInterest_SwiftUIApp.swift
//  MoviesInterest_SwiftUI
//
//  Created by Pradeep Dahiya on 07/03/23.
//

import SwiftUI

@main
struct MoviesInterest_SwiftUIApp: App {
    @StateObject private var viewModelFactory = ViewModelFactory()
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: viewModelFactory.makeMovieListVM())
              .accentColor(.mainTint)
              .environmentObject(viewModelFactory)
        }
    }
}
