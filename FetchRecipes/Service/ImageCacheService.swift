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
    private var imageCacheDir: URL? = nil
    
    init?(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        
        guard let cacheDir = try? fileManager.url(for: .cachesDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true) else { return }
        let imageCacheDir = cacheDir.appendingPathComponent("images")
        
        if !fileManager.fileExists(atPath: imageCacheDir.path) {
            do {
                try fileManager.createDirectory(at: imageCacheDir, withIntermediateDirectories: true)
            } catch {
                return
            }
        }
        
        self.imageCacheDir = imageCacheDir
    }
    
    func fetchImage(from url: URL) async throws -> UIImage? {
        if let image = fetchImageFromCache(url: url.absoluteString) { return image }
        guard let image = try? await networkService.fetchImage(from: url) else { return nil }
        cacheImage(url: url.absoluteString, image: image)
        return image
    }
    
    func fetchImageFromCache(url: String) -> UIImage? {
        guard let imageCacheDir else { return nil }
        let imagePath = imageCacheDir.appendingPathComponent(url)
        if let imageData = try? Data(contentsOf: imagePath), let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    func cacheImage(url: String, image: UIImage) {
        guard let imageCacheDir else { return }
        let imageUrl = imageCacheDir.appendingPathComponent(url)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        try? data.write(to: imageUrl)
    }
}
