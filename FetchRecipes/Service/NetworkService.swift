//
//  NetworkService.swift
//  FetchRecipes
//
//  Created by Kevin Sullivan on 1/18/25.
//

import Foundation
import UIKit

enum NetworkError: Error, Equatable {
    case invalidResponse(_ statusCode: Int)
    case badData
}

protocol NetworkServiceProtocol {
    func fetchJson<T: Codable>(_ type: T.Type, from url: URL) async throws -> T
    func fetchImage(from url: URL) async throws -> UIImage?
}

class NetworkService: NetworkServiceProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchJson<T: Codable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await urlSession.data(from: url)
        
        if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
            throw(NetworkError.invalidResponse(statusCode))
        }
        
        do {
            let jsonResponse = try JSONDecoder().decode(T.self, from: data)
            return jsonResponse
        } catch {
            throw NetworkError.badData
        }
    }
    
    func fetchImage(from url: URL) async throws -> UIImage? {
        let (data, response) = try await urlSession.data(from: url)
        
        if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
            throw(NetworkError.invalidResponse(statusCode))
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.badData
        }
        
        return image
    }
}
