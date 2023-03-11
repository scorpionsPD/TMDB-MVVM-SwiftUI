//
//  Endpoint.swift
//  Movies
//
//  Created by Pradeep Dahiya on 16/09/2022.
//

import Foundation
/// The endpoint for a specific API request
protocol Endpoint {
  /// the url representation of the endpoint
  var url: URL { get }
}
