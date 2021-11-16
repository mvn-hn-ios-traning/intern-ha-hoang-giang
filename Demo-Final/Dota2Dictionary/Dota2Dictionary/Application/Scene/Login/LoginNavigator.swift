//
//  LoginNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit

protocol DefaultLoginNavigator {
    func toRegister()
}

class LoginNavigator: DefaultLoginNavigator {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
    }
    
    func toRegister() {
        let navigator = RegisterNavigator(navigationController: navigationController)
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "RegisterViewController")
                as? RegisterViewController else {
            return
        }
        viewController.registerViewModel = RegisterViewModel(navigator: navigator)
        navigationController.pushViewController(viewController, animated: true)
    }
}
