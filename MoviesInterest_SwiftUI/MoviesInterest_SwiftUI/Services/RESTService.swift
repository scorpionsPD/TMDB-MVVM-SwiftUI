//
//  RESTService.swift
//  Movies
//
//  Created by Pradeep Dahiya on 16/09/2022.
//

import Foundation

/// A protocol to define a service that interacts with an API using the RESTful architecture
protocol RESTService {
  /// GET request to the api, passing in the desired endpoint of the request and obtaining the desired resource
  /// - Parameter endpoint: the endpoint specific to the desired API call
  /// - Returns: A decoded object of the given type for this request
  func get<T: Decodable>(endpoint: Endpoint) async throws -> T
}
