//
//  ProfileNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit

protocol DefaultProfileNavigator {
    func toProfile()
    func toLoginScreen()
}

class ProfileNavigator: DefaultProfileNavigator {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
    }
    
    func toProfile() {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "ProfileViewController")
                as? ProfileViewController else {
            return
        }
        viewController.profileViewModel = ProfileViewModel(navigator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toLoginScreen() {
        let navigator = LoginNavigator(storyBoard: storyBoard,
                                       navigationController: navigationController)
        guard let viewController = storyBoard
            .instantiateViewController(withIdentifier: "LoginViewController")
            as? LoginViewController else {
                return
        }
        viewController.loginViewModel = LoginViewModel(navigator: navigator)
        navigationController.pushViewController(viewController, animated: true)
    }
}
