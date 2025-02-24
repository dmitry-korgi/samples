//
//  AssetsService.swift
//  sandbox
//
//  Created by Botonota on 24.02.2025.
//

import Foundation
import Combine

private enum Constants: String {
    case baseURL = "https://api.coincap.io/v2/assets"
    case limit = "limit"
    case offset = "offset"
}

protocol AssetServiceProtocol {
    func fetchAssets(limit: Int, offset: Int) -> AnyPublisher<[Asset], Error>
}

class AssetService: AssetServiceProtocol {
    private let baseURL = Constants.baseURL
    
    func fetchAssets(limit: Int, offset: Int) -> AnyPublisher<[Asset], Error> {
        var components = URLComponents(string: baseURL.rawValue)!
        components.queryItems = [
            URLQueryItem(name: Constants.offset.rawValue, value: "\(offset)"),
            URLQueryItem(name: Constants.limit.rawValue, value: "\(limit)")
        ]
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: AssetsResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
