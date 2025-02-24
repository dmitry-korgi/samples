//
//  Asset.swift
//  sandbox
//
//  Created by Botonota on 23.02.2025.
//

import Foundation

struct Asset: Codable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let priceUsd: String?
    let changePercent24Hr: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case rank
        case symbol
        case name
        case priceUsd
        case changePercent24Hr
    }
}

struct AssetsResponse: Codable {
    let data: [Asset]
}
