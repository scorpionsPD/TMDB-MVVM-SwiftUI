//
//  Genre.swift
//  Movies
//
//  Created by Pradeep Dahiya on 19/12/2022.
//

import Foundation

// Model for genre info of a movie
struct Genre: Decodable, Equatable, Identifiable {
  /// unique identifier for this genre
  var id: Int
  /// name for this genre
  var name: String
}
