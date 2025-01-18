//
//  RecipesViewModel.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import SwiftUI

enum RecipeViewState: Identifiable {
    var id: Self { self }
    
    case loading
    case loaded
    case networkError
    case malformedData
    case emptyData
}

private let recipeUrl = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
private let malformedData = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
private let emptyData = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!

@Observable class RecipesViewModel {
    private let networkService: NetworkServiceProtocol
    var recipes: [Recipe] = []
    var state: RecipeViewState = .loading
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchRecipes() async {
        do {
            let recipeResponse = try await networkService.fetchJson(RecipeResponse.self, from: recipeUrl)
            recipes = recipeResponse.recipes
            state = recipes.isEmpty ? .emptyData : .loaded
        } catch let error as NetworkError {
            switch error {
            case .invalidResponse:
                state = .networkError
            case .badData:
                state = .malformedData
            }
        } catch {
            state = .networkError
        }
    }
}
