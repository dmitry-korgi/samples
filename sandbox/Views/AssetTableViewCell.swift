//
//  AssetTableViewCell.swift
//  sandbox
//
//  Created by Botonota on 24.02.2025.
//

import UIKit

//TODO: добавить верстку с отображением логотипа ассета и другими шрифтами
class AssetTableViewCell: UITableViewCell {
    static let reuseIdentifier = "AssetTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }
    
    func update(with asset: Asset) {
        textLabel?.text = asset.name
        detailTextLabel?.text = "\(asset.symbol) - \(asset.priceUsd ?? ":(")"
    }
}
