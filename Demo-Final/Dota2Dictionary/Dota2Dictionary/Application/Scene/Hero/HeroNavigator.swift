//
//  HeroNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 12/10/2021.
//

import UIKit

protocol DefaultHeroNavigator {
    func toHero()
    func toHeroDetail()
}

class HeroNavigator: DefaultHeroNavigator {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: HeroUseCaseProviderDomain
    
    init(services: HeroUseCaseProviderDomain,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toHero() {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "HeroViewController")
                as? HeroViewController else {
            return
        }
        viewController.heroViewModel = HeroViewModel(useCase: services.makeHeroUseCase())
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toHeroDetail() {
        
    }
}
