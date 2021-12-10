//
//  ProfileNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit

protocol DefaultProfileNavigator {
    func toProfile()
    func toRegister()
    func toLikeDetail(_ viewModel: HeroLikedModel)
}

class ProfileNavigator: DefaultProfileNavigator {
    
    private let profileService: ProfileUseCaseProviderDomain
    private let registerService: RegisterUseCaseProviderDomain
    private let likedHeroService: HeroDetailUseCaseProviderDomain
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(profileService: ProfileUseCaseProviderDomain,
         registerService: RegisterUseCaseProviderDomain,
         likedHeroService: HeroDetailUseCaseProviderDomain,
         storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.profileService = profileService
        self.registerService = registerService
        self.likedHeroService = likedHeroService
        self.storyBoard = storyBoard
        self.navigationController = navigationController
    }
    
    func toProfile() {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "ProfileViewController")
                as? ProfileViewController else {
            return
        }
        viewController.profileViewModel = ProfileViewModel(useCase: profileService.makeProfileUseCase(),
                                                           navigator: self)
        navigationController.pushViewController(viewController, animated: true)
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
        navigationController.present(viewController, animated: true)
    }
    
    func toLikeDetail(_ viewModel: HeroLikedModel) {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "HeroDetailViewController")
                as? HeroDetailViewController else {
            return
        }
        viewController.heroDetailViewModel = HeroDetailViewModel(heroID: viewModel.heroId,
                                                                 heroNameOriginal: viewModel.name,
                                                                 useCase: likedHeroService.makeHeroDetailUseCase())
        navigationController.pushViewController(viewController, animated: true)
    }
}
