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
    private let patchDetailUseCaseProvider: PatchDetailUseCaseProviderDomain
    
    private let heroUseCaseProvider: HeroUseCaseProviderDomain
    private let heroDetailUseCaseProvider: HeroDetailUseCaseProviderDomain
    
    private let itemUseCaseProvider: ItemUseCaseProviderDomain
    private let itemDetailUseCaseProvider: ItemDetailUseCaseProviderDomain
    
    private init() {
        self.patchUseCaseProvider = PatchUseCaseProviderPlatform()
        self.patchDetailUseCaseProvider = PatchDetailUseCaseProviderPlatform()
        
        self.heroUseCaseProvider = HeroUseCaseProviderPlatform()
        self.heroDetailUseCaseProvider = HeroDetailUseCaseProviderPlatform()
        
        self.itemUseCaseProvider = ItemUseCaseProviderPlatform()
        self.itemDetailUseCaseProvider = ItemDetailUseCaseProviderPlatform()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let patchNavigationController = UINavigationController()
        patchNavigationController.tabBarItem = UITabBarItem(title: "Patch",
                                                            image: UIImage(systemName: "book"),
                                                            selectedImage: nil)
        patchNavigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        patchNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let patchNavigator = PatchNavigator(services: patchUseCaseProvider,
                                            servicesDetail: patchDetailUseCaseProvider,
                                            navigationController: patchNavigationController,
                                            storyBoard: storyboard)
        
        let heroNavigationController = UINavigationController()
        heroNavigationController.tabBarItem = UITabBarItem(title: "Hero",
                                                           image: UIImage(systemName: "face.smiling"),
                                                           selectedImage: nil)
        heroNavigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        heroNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let heroNavigator = HeroNavigator(services: heroUseCaseProvider,
                                          servicesDetail: heroDetailUseCaseProvider,
                                          navigationController: heroNavigationController,
                                          storyBoard: storyboard)
        
        let itemNavigationController = UINavigationController()
        itemNavigationController.tabBarItem = UITabBarItem(title: "Item",
                                                           image: UIImage(systemName: "pencil.slash"),
                                                           selectedImage: nil)
        itemNavigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        itemNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let itemNavigator = ItemNavigator(services: itemUseCaseProvider,
                                          servicesDetail: itemDetailUseCaseProvider,
                                          navigationController: itemNavigationController,
                                          storyBoard: storyboard)
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [patchNavigationController,
                                            heroNavigationController,
                                            itemNavigationController]
        
        window.rootViewController = tabbarController
        
        tabbarController.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        tabbarController.tabBar.tintColor = UIColor.link
        
        patchNavigator.toPatch()
        heroNavigator.toHero()
        itemNavigator.toItem()
    }
    
}
