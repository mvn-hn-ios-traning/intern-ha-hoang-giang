//
//  Application.swift
//  Dota2Dictionary
//
//  Created by MacOS on 11/10/2021.
//

import UIKit

final class Application {
    static let shared = Application()
    
    private let patchUseCaseProvider: PatchUseCaseProviderDomain
    private let heroUseCaseProvider: HeroUseCaseProviderDomain
    private let itemUseCaseProvider: ItemUseCaseProviderDomain
    
    private init() {
        self.patchUseCaseProvider = PatchUseCaseProviderPlatform()
        self.heroUseCaseProvider = HeroUseCaseProviderPlatform()
        self.itemUseCaseProvider = ItemUseCaseProviderPlatform()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let patchNavigationController = UINavigationController()
        patchNavigationController.tabBarItem = UITabBarItem(title: "Patch",
                                                            image: UIImage(systemName: "book"),
                                                            selectedImage: nil)
        let patchNavigator = PatchNavigator(services: patchUseCaseProvider,
                                                   navigationController: patchNavigationController,
                                                   storyBoard: storyboard)
        
        let heroNavigationController = UINavigationController()
        heroNavigationController.tabBarItem = UITabBarItem(title: "Hero",
                                                            image: UIImage(systemName: "face.smiling"),
                                                            selectedImage: nil)
        let heroNavigator = HeroNavigator(services: heroUseCaseProvider,
                                          navigationController: heroNavigationController,
                                          storyBoard: storyboard)
        
        let itemNavigationController = UINavigationController()
        itemNavigationController.tabBarItem = UITabBarItem(title: "Item",
                                                            image: UIImage(systemName: "pencil.slash"),
                                                            selectedImage: nil)
        let itemNavigator = ItemNavigator(services: itemUseCaseProvider,
                                          navigationController: itemNavigationController,
                                          storyBoard: storyboard)
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [patchNavigationController,
                                            heroNavigationController,
                                            itemNavigationController]
        
        window.rootViewController = tabbarController
        
        patchNavigator.toPatch()
        heroNavigator.toHero()
        itemNavigator.toItem()
    }
    
}
