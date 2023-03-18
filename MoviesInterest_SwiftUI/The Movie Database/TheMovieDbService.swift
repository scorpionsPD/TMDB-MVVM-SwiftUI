//
//  TheMovieDbService.swift
//  Movies
//
//  Created by Pradeep Dahiya on 16/09/2022.
//

import Foundation

extension URL {
    /// Base URL to The Movie Database API
    static var theMovieDbBaseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
}

/// Handles requests to The Movie Database API
/// https://developers.themoviedb.org/3/
final actor TheMovieDbService: RESTService {
    private var apiKey: String
    private let baseURL: URL
    private let urlSession: URLSession
    private let decoder = JSONDecoder()
    /// Instantiates this class with an api key, that is provided specifically for a particular app
    /// - Parameters:
    ///   - apiKey: The app specific api key for The Movie Database
    ///   - baseURL: The URL that is prefixed to all API requests
    ///   - urlSession: The URL session that will perform the network requests
    init(
        apiKey: String,
        baseURL: URL = URL.theMovieDbBaseURL,
        urlSession: URLSession = URLSession.shared
    ) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    private func buildURLRequest(for endpoint: Endpoint) throws -> URLRequest {
        // TODO: add logs for this function
        var components = URLComponents(url: endpoint.url, resolvingAgainstBaseURL: true)
        components?.scheme = baseURL.scheme
        components?.host = baseURL.host
        let path = "\(baseURL.path)\(components?.path ?? "")"
        components?.path = path
        var queryItems = components?.queryItems ?? []
        // add api key
        queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        // add current language code
        queryItems.append(URLQueryItem(name: "language", value: Locale.current.languageCode))
        components?.queryItems = queryItems
        guard let components = components, let requestURL = components.url else {
            throw TheMovieDbError.malformed
        }
        return URLRequest(url: requestURL)
    }
    private func validate(response: URLResponse) throws {
        let status = (response as? HTTPURLResponse)?.statusCode ?? -1
        if status != 200 { // handle response errors
            switch status {
            case 401:
                throw TheMovieDbError.unauthorized
            case 404:
                throw TheMovieDbError.notFound
            default:
                throw TheMovieDbError.unknown
            }
        }
    }
    private func decode<T: Decodable>(responseData: Data) async throws -> T {
        let result: T
        do {
            result = try decoder.decode(T.self, from: responseData)
        } catch {
            throw TheMovieDbError.parsing
        }
        return result
    }
    // MARK: GET
    func get<T: Decodable>(endpoint: Endpoint) async throws -> T {
        // construct request
        let request = try buildURLRequest(for: endpoint)
        let data: Data
        let response: URLResponse
        print("GET request to The Movie Database: \(request)")
        // make the request
        do {
            (data, response) = try await urlSession.data(for: request)
        } catch {
            throw error
        }
        // validate response
        try validate(response: response)
        // decode response data
        return try await decode(responseData: data)
    }
}
