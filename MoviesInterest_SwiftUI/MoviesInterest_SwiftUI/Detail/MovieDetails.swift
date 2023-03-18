//
//  MovieDetails.swift
//  Movies
//
//  Created by Pradeep Dahiya on 16/03/23.
//

import SwiftUI

struct MovieDetails: View {
    let id: Int
    @StateObject var viewModel: DetailViewModal
    var body: some View {
        AsyncImage(url: viewModel.movie?.posterURL()) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
            case .success(let image):
                ScrollView {
                    VStack {
                        ImagePreview(image: image)
                        GenereText(viewM: viewModel)
                        OverviewText(viewM: viewModel)
                        Spacer()
                    }
                }
            case .failure:
                Color.gray
            @unknown default:
                Color.red // more obvious a case is not handled
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.movie?.title ?? "")
        .task {
            // get movies details
            await viewModel.fetchMovieDetail(id)
        }
    }
}
/// poster image
struct ImagePreview: View {
    let image: Image
    var body: some View {
        image
    }
}
/// short overview of movie
struct OverviewText: View {
    let viewM: DetailViewModal
    var body: some View {
        Text(viewM.movie?.overview ?? "")
            .foregroundColor(Color.primaryText)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding()
    }
}
/// all genere of movie 
struct GenereText: View {
    let viewM: DetailViewModal
    var body: some View {
        Text(viewM.formatedGenereString())
            .foregroundColor(Color.primaryText)
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding()
    }
}
