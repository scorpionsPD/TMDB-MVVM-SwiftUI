//
//  Movie.swift
//  Movies
//
//  Created by Pradeep Dahiya on 19/12/2022.
//

import Foundation

/// Model object for a particular movie
struct Movie: Decodable, Equatable, Identifiable {

  /// unique identifier for this movie
  var id: Int
  /// The title of the movie
  var title: String
  /// The date the movie was releases
  var releaseDate: String
  /// Path to a poster for this movie
  var poster: String?
  /// Path to a backdrop picture for this movie
  var backdrop: String?
  /// A sentence to sell the movie
  var tagline: String?
  /// brief overview of what the movie is about
  var overview: String
  /// duration of the movie
  var runtime: Int?
  /// all genres of the movie
  var genres: [Genre]?

  /// JSON key to variable mappings
  enum CodingKeys: String, CodingKey {
    case id
    case title = "original_title"
    case releaseDate = "release_date"
    case poster = "poster_path"
    case backdrop = "backdrop_path"
    case tagline
    case overview
    case runtime
    case genres
  }
}

extension Movie {

  /// Runtime formatted into hours and minutes
  /// - Returns: a string with the runtime formatted accordingly
  func formattedRuntime() -> String {
    guard let runtime = runtime else {
     print("no runtime to format")
      return ""
    }
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute]
    formatter.unitsStyle = .full
    return formatter.string(from: TimeInterval(runtime*60)) ?? ""
  }
}

extension Movie {

  private static let basePosterURL = "https://image.tmdb.org/t/p/w185"
  private static let baseBackdropURL = "https://image.tmdb.org/t/p/w780"

  /// URL for getting a poster image for the movie
  /// - Returns: a URL of where to get the image
  func posterURL() -> URL? {
    guard let posterPath = poster else {
    print("unable to resolve posterURL - no image path")
      return nil
    }
    return URL(string: Movie.basePosterURL.appending(posterPath))
  }

  /// URL for getting a banner image for the movie
  /// - Returns: a URL of where to get the image
  func backdropURL() -> URL? {
    guard let backdropPath = backdrop else {
    print("unable to resolve backdropURL - no image path")
      return nil
    }
    return URL(string: Movie.baseBackdropURL.appending(backdropPath))
  }
}
