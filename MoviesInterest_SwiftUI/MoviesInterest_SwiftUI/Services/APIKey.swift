//
//  APIKey.swift
//  MoviesInterest_SwiftUI
//
//  Created by Pradeep Dahiya on 07/03/23.
//

import Foundation
import UIKit
enum ApiKeyStore {
    static let theMovieDbKey = getValue(forKey: "MOVIEDB_KEY")
    private static func getValue(forKey key: String) -> String {
        guard let data = NSDataAsset(name: "ApiKeys")?.data,
            let plist = try? PropertyListSerialization
                .propertyList(from: data, options: [], format: nil) as? NSDictionary
            else { fatalError("ApiKeys data set with plist not found") }
        guard let value = plist.object(forKey: key) as? String
            else { fatalError("Can't find value for apikey: \(key)") }
        return value
    }
}
