//
//  TheMovieDbError.swift
//  Movies
//
//  Created by Pradeep Dahiya on 19/12/2022.
//

import Foundation

/// Errors specific to communication with the Movie Database API
public enum TheMovieDbError: Error {
  case malformed
  case network(Error)
  case unauthorized
  case notFound
  case parsing
  case unknown
}

extension TheMovieDbError: LocalizedError {

  /// A description for what the error relates to
  public var errorDescription: String? {
    switch self {
    case .malformed:
      return "malformed request"
    case .network(let error):
      return "network error: \(error.localizedDescription)"
    case .unauthorized:
      return "error authorising request"
    case .notFound:
      return "nothing found for request"
    case .parsing:
      return "error parsing response data"
    case .unknown:
      return "unknown error occured"
    }
  }
}
