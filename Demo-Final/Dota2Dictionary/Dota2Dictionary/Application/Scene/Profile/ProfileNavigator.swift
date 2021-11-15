//
//  ProfileNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit

class ProfileNavigator {
    
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
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "LoginViewController")
                as? LoginViewController else {
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
