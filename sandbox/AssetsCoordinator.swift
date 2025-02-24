//
//  AssetsCoordinator.swift
//  sandbox
//
//  Created by Botonota on 23.02.2025.
//

import UIKit

//TODO: добавить навигацию на экран детальной информации
class AssetsCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let assetService = AssetService()
        let viewModel = AssetsViewModel(assetService: assetService)
        let viewController = AssetsViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }
}
