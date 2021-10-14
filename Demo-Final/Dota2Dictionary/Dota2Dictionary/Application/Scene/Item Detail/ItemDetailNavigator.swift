//
//  ItemDetailNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 12/10/2021.
//

import UIKit

protocol DefaultItemDetailNavigator {
    func toItem()
}

final class ItemDetailNavigator: DefaultItemDetailNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toItem() {
        
    }
}
