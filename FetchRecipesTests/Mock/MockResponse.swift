//
//  MockRecipeResponse.swift
//  FetchRecipesTests
//
//  Created by Kevin Sullivan on 1/19/25.
//

import UIKit
import Foundation
import Testing

class MockResponse {
    static let validRecipes = """
        {
            "recipes": [
                {
                    "cuisine": "Malaysian",
                    "name": "Apam Balik",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                    "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                    "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                }
            ]
        }
    """.data(using: .utf8)
    
    static let emptyRecipes = """
        {
            "recipes": []
        }
    """.data(using: .utf8)
    
    static let malformedRecipes = "{ badData }".data(using: .utf8)
    
    static let validImage = #imageLiteral(resourceName: "recipePlaceholder").jpegData(compressionQuality: 1)
    static let malformedImage = Data(repeating: 1, count: 5)
    
    static func response(for url: URL, statusCode: Int) -> HTTPURLResponse? {
        return HTTPURLResponse(url: url,
                               statusCode: statusCode,
                               httpVersion: nil,
                               headerFields: nil)
    }
}
