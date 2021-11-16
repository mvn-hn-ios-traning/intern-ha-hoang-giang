//
//  RegisterNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 16/11/2021.
//

import UIKit

protocol DefaultRegisterNavigator {
    
}

class RegisterNavigator: DefaultRegisterNavigator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toLogin() {
        navigationController.popViewController(animated: true)
    }
}
