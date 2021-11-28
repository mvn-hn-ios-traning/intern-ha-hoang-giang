//
//  HeroNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 12/10/2021.
//

import UIKit

protocol DefaultHeroNavigator {
    func toHero()
    func toHeroDetail(_ viewModel: HeroViewModelPlus)
}

class HeroNavigator: DefaultHeroNavigator {
    
    private let services: HeroUseCaseProviderDomain
    private let servicesDetail: HeroDetailUseCaseProviderDomain
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(services: HeroUseCaseProviderDomain,
         servicesDetail: HeroDetailUseCaseProviderDomain,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.servicesDetail = servicesDetail
        self.navigationController = navigationController
        self.storyBoard = storyBoard
        
    }
    
    func toHero() {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "HeroViewController")
                as? HeroViewController else {
            return
        }
        viewController.heroViewModel = HeroViewModel(useCase: services.makeHeroUseCase(),
                                                     navigator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toHeroDetail(_ viewModel: HeroViewModelPlus) {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "HeroDetailViewController")
                as? HeroDetailViewController else {
            return
        }
        viewController.heroDetailViewModel = HeroDetailViewModel(heroID: viewModel.newID,
                                                                 heroNameOriginal: viewModel.heroNameOriginal,
                                                                 useCase: servicesDetail.makeHeroDetailUseCase())
        navigationController.pushViewController(viewController, animated: true)
    }
}
