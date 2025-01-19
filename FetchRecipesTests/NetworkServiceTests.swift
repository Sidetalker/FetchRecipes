//
//  FetchRecipesTests.swift
//  FetchRecipesTests
//
//  Created by Kevin Sullivan on 1/18/25.
//

import Foundation
import Testing
import UIKit
@testable import FetchRecipes

@Suite("Networking Tests", .serialized)
struct NetworkServiceTests {
    
    let urlSession: URLSession
    let networkService: NetworkService
    let mockUrl = URL(string: "www.test.com")!
    
    init() {
        let config: URLSessionConfiguration = .ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        networkService = NetworkService(urlSession: urlSession)
    }
    
    func configureRequestHandler(statusCode: Int, data: Data?) throws {
        MockURLProtocol.requestHandler = { _ in
            let response = try #require(MockResponse.response(for: mockUrl, statusCode: statusCode),
                                       "Error unwrapping response object")
            return (response, data)
        }
    }

    @Test func fetchRecipesSuccess() async throws {
        try configureRequestHandler(statusCode: 200, data: MockResponse.validRecipes)
        async #expect(throws: Never.self) {
            let recipeResponse = try await networkService.fetchJson(RecipeResponse.self, from: mockUrl)
            #expect(recipeResponse.recipes.count == 1)
        }
    }
    
    @Test func fetchRecipes404() async throws {
        try configureRequestHandler(statusCode: 404, data: nil)
        await #expect(throws: NetworkError.invalidResponse(404)) {
            try await networkService.fetchJson(RecipeResponse.self, from: mockUrl)
        }
    }
    
    @Test func fetchRecipesMalformed() async throws {
        try configureRequestHandler(statusCode: 200, data: MockResponse.malformedRecipes)
        await #expect(throws: NetworkError.badData) {
            try await networkService.fetchJson(RecipeResponse.self, from: mockUrl)
        }
    }
    
    @Test func fetchImageSuccess() async throws {
        try configureRequestHandler(statusCode: 200, data: MockResponse.validImage)
        async #expect(throws: Never.self) {
            try await networkService.fetchImage(from: mockUrl)
        }
    }
    
    @Test func fetchImage404() async throws {
        try configureRequestHandler(statusCode: 404, data: nil)
        await #expect(throws: NetworkError.invalidResponse(404)) {
            try await networkService.fetchImage(from: mockUrl)
        }
    }
    
    @Test func fetchImageMalformed() async throws {
        try configureRequestHandler(statusCode: 200, data: MockResponse.malformedImage)
        await #expect(throws: NetworkError.badData) {
            try await networkService.fetchImage(from: mockUrl)
        }
    }
}
