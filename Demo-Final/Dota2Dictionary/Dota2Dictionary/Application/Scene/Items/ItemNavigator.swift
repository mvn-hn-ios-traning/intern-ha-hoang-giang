//
//  ItemNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 12/10/2021.
//

import UIKit

protocol DefaultItemNavigator {
    func toItem()
    func toItemDetail()
}

class ItemNavigator: DefaultItemNavigator {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: ItemUseCaseProviderDomain
    
    init(services: ItemUseCaseProviderDomain,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toItem() {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "ItemsViewController")
                as? ItemsViewController else {
            return
        }
        viewController.itemViewModel = ItemViewModel()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toItemDetail() {
        
    }
}
