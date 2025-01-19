//
//  ImageCacheServiceTests.swift
//  FetchRecipesTests
//
//  Created by Kevin Sullivan on 1/19/25.
//

import Testing
import UIKit
@testable import FetchRecipes

@Suite("Image Cache Tests", .serialized)
struct ImageCacheServiceTests {
    
    let imageCacheService: ImageCacheService
    let testImageUrl = URL(string: "www.test.com/test/with/slashes")!
    let testImage = #imageLiteral(resourceName: "recipePlaceholder")
    
    init() throws {
        let mockNetworkService = MockNetworkService()
        mockNetworkService.returnedImage = testImage
        imageCacheService = try #require(ImageCacheService(networkService: mockNetworkService), "Initialization failed")
        imageCacheService.clearCache()
    }

    @Test func testFetchImageFromCacheFailed() throws {
        #expect(imageCacheService.fetchImageFromCache(url: testImageUrl) == nil)
    }
    
    @Test func testCacheReadWrite() throws {
        imageCacheService.cacheImage(url: testImageUrl, image: testImage)
        #expect(imageCacheService.fetchImageFromCache(url: testImageUrl)?.pngData() == testImage.pngData())
    }
    
    @Test func testFetchImageFromNetwork() async throws {
        try await #expect(imageCacheService.fetchImage(from: testImageUrl)?.pngData() == testImage.pngData())
        #expect(imageCacheService.fetchImageFromCache(url: testImageUrl)?.pngData() == testImage.pngData())
    }

}
