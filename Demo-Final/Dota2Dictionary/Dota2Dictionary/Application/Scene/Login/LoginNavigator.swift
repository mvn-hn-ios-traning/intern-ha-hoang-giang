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
    
    private let registerService: RegisterUseCaseProviderDomain
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(registerService: RegisterUseCaseProviderDomain,
         storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.registerService = registerService
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
        viewController.registerViewModel = RegisterViewModel(useCase: registerService.makeRegisterUseCase(),
                                                             navigator: navigator)
        navigationController.pushViewController(viewController, animated: true)
    }
}
