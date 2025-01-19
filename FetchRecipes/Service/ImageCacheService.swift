//
//  CacheService.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import UIKit

class ImageCacheService {
    private let networkService: NetworkServiceProtocol
    private let fileManager = FileManager.default
    private var imageCacheDir: URL
    
    init?(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        
        guard let cacheDir = try? fileManager.url(for: .cachesDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true) else { return nil }
        let imageCacheDir = cacheDir.appendingPathComponent("images")
        
        if !fileManager.fileExists(atPath: imageCacheDir.path) {
            do {
                try fileManager.createDirectory(at: imageCacheDir, withIntermediateDirectories: true)
            } catch {
                return nil
            }
        }
        
        self.imageCacheDir = imageCacheDir
    }
    
    private func filename(from url: URL) -> String {
        return url.path().filter { $0 != "/" }
    }
    
    func fetchImage(from url: URL) async throws -> UIImage? {
        if let image = fetchImageFromCache(url: url) { return image }
        guard let image = try? await networkService.fetchImage(from: url) else { return nil }
        cacheImage(url: url, image: image)
        return image
    }
    
    func fetchImageFromCache(url: URL) -> UIImage? {
        let imagePath = imageCacheDir.appendingPathComponent(filename(from: url))
        if let imageData = try? Data(contentsOf: imagePath), let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    func cacheImage(url: URL, image: UIImage) {
        let imageUrl = imageCacheDir.appendingPathComponent(filename(from: url))
        guard let data = image.pngData() else { return }
        try? data.write(to: imageUrl)
    }
    
    func clearCache() {
        try? fileManager.contentsOfDirectory(atPath: imageCacheDir.path()).forEach { path in
            try! fileManager.removeItem(atPath: imageCacheDir.path() + path)
        }
    }
}
