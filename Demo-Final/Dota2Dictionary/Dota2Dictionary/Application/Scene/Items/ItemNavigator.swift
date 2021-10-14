//
//  ItemNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 12/10/2021.
//

import UIKit

protocol DefaultItemNavigator {
    func toItem()
    func toItemDetail(_ string: String)
}

class ItemNavigator: DefaultItemNavigator {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: ItemUseCaseProviderDomain
    private let servicesDetail: ItemDetailUseCaseProviderDomain
    
    init(services: ItemUseCaseProviderDomain,
         servicesDetail: ItemDetailUseCaseProviderDomain,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
        self.servicesDetail = servicesDetail
    }
    
    func toItem() {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "ItemsViewController")
                as? ItemsViewController else {
            return
        }
        viewController.itemViewModel = ItemViewModel(useCase: services.makeItemUseCase(),
                                                     navigator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toItemDetail(_ string: String) {
//        let navigator = ItemDetailNavigator(navigationController: navigationController)
        let viewModel = ItemDetailViewModel(itemKey: string,
                                            useCase: servicesDetail.makeItemDetailUseCase())
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "ItemDetailViewController")
                as? ItemDetailViewController else {
            return
        }
        viewController.itemDetailViewModel = viewModel
        viewController.title = string
        navigationController.pushViewController(viewController, animated: true)
    }
}
