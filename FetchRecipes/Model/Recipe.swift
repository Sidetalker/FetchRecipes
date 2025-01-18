//
//  Recipe.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import Foundation

struct Recipe: Codable, Identifiable {
    var id: String { return uuid }
    
    var uuid: String
    var cuisine: String
    var name: String
    
    var photoUrlLarge: URL?
    var photoUrlSmall: URL?
    var sourceUrl: URL?
    var youtubeUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
    
    static let placeholder = Recipe(uuid: NSUUID().uuidString,
                                    cuisine: String(repeating: "X", count: 10),
                                    name: String(repeating: "X", count: 10))
}

struct RecipeResponse: Codable {
    var recipes: [Recipe]
}
