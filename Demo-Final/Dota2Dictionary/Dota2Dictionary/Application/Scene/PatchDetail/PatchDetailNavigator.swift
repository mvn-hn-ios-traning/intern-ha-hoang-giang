//
//  PatchDetailNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 12/10/2021.
//

import UIKit

protocol DefaultPatchDetailNavigator {
    func toPatch()
}

class PatchDetailNavigator: DefaultPatchDetailNavigator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toPatch() {
        navigationController.popViewController(animated: true)
    }
    
}
