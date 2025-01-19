//
//  MockNetworkServiceProtocol.swift
//  FetchRecipesTests
//
//  Created by Kevin Sullivan on 1/19/25.
//

import Foundation
import UIKit
@testable import FetchRecipes

class MockNetworkService: NetworkServiceProtocol {
    var returnedImage: UIImage?
    var error: (any Error)?
    var response: Data?
    
    func fetchJson<T: Codable>(_ type: T.Type, from url: URL) async throws -> T {
        if let error {
            throw error
        }
        
        if let response {
            return try JSONDecoder().decode(T.self, from: response)
        }
        
        throw NSError(domain: "Not Implemented", code: -1)
    }
    
    func fetchImage(from url: URL) async throws -> UIImage? {
        return returnedImage
    }
}
