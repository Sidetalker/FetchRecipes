//
//  RecipesViewModelTests.swift
//  FetchRecipesTests
//
//  Created by Kevin Sullivan on 1/19/25.
//

import Foundation
import Testing
@testable import FetchRecipes

@Suite("View Model Tests")
struct RecipesViewModelTests {

    @Test func testFetchSuccess() async throws {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.response = MockResponse.validRecipes
        let viewModel = RecipesViewModel(networkService: mockNetworkService)
        #expect(viewModel.state == .loading)
        await viewModel.fetchRecipes()
        #expect(viewModel.state == .loaded)
        #expect(viewModel.recipes.count == 1)
    }
    
    @Test func testFetchEmpty() async throws {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.response = MockResponse.emptyRecipes
        let viewModel = RecipesViewModel(networkService: mockNetworkService)
        #expect(viewModel.state == .loading)
        await viewModel.fetchRecipes()
        #expect(viewModel.state == .emptyData)
        #expect(viewModel.recipes.count == 0)
    }
    
    @Test func testFetchMalformed() async throws {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.error = NetworkError.badData
        let viewModel = RecipesViewModel(networkService: mockNetworkService)
        #expect(viewModel.state == .loading)
        await viewModel.fetchRecipes()
        #expect(viewModel.state == .malformedData)
        #expect(viewModel.recipes.count == 0)
    }
    
    @Test func testFetchNetworkError() async throws {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.error = NetworkError.invalidResponse(400)
        let viewModel = RecipesViewModel(networkService: mockNetworkService)
        #expect(viewModel.state == .loading)
        await viewModel.fetchRecipes()
        #expect(viewModel.state == .networkError)
        #expect(viewModel.recipes.count == 0)
    }
    
    @Test func testFetchUnhandledError() async throws {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.error = NSError(domain: "Unhandled", code: -1)
        let viewModel = RecipesViewModel(networkService: mockNetworkService)
        #expect(viewModel.state == .loading)
        await viewModel.fetchRecipes()
        #expect(viewModel.state == .networkError)
        #expect(viewModel.recipes.count == 0)
    }
}
