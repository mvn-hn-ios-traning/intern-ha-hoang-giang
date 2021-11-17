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
    
    private let loginService: LoginUseCaseProviderDomain
    private let registerService: RegisterUseCaseProviderDomain
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(loginService: LoginUseCaseProviderDomain,
         registerService: RegisterUseCaseProviderDomain,
         storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.loginService = loginService
        self.registerService = registerService
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
        let navigator = LoginNavigator(registerService: registerService,
                                       storyBoard: storyBoard,
                                       navigationController: navigationController)
        guard let viewController = storyBoard
            .instantiateViewController(withIdentifier: "LoginViewController")
            as? LoginViewController else {
                return
        }
        viewController.loginViewModel = LoginViewModel(useCase: loginService.makeLoginUseCase(),
                                                       navigator: navigator)
        navigationController.pushViewController(viewController, animated: true)
    }
}
