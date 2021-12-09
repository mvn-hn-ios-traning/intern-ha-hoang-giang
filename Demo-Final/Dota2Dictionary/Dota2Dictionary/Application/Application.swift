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
    
    private let profileUseCaseProvider: ProfileUseCaseProviderDomain
    private let registerUseCaseProvider: RegisterUseCaseProviderDomain
    
    private init() {
        self.patchUseCaseProvider = PatchUseCaseProviderPlatform()
        self.patchDetailUseCaseProvider = PatchDetailUseCaseProviderPlatform()
        
        self.heroUseCaseProvider = HeroUseCaseProviderPlatform()
        self.heroDetailUseCaseProvider = HeroDetailUseCaseProviderPlatform()
        
        self.itemUseCaseProvider = ItemUseCaseProviderPlatform()
        self.itemDetailUseCaseProvider = ItemDetailUseCaseProviderPlatform()
        
        self.profileUseCaseProvider = ProfileUseCaseProviderPlatform()
        self.registerUseCaseProvider = RegisterUseCaseProviderPlatform()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let patchNavigationController = UINavigationController()
        patchNavigationController.tabBarItem = UITabBarItem(title: "Patch",
                                                            image: UIImage(systemName: "book"),
                                                            selectedImage: nil)
        
        let patchNavigator = PatchNavigator(services: patchUseCaseProvider,
                                            servicesDetail: patchDetailUseCaseProvider,
                                            navigationController: patchNavigationController,
                                            storyBoard: storyboard)
        
        let heroNavigationController = UINavigationController()
        heroNavigationController.tabBarItem = UITabBarItem(title: "Hero",
                                                           image: UIImage(named: "hero_icon"),
                                                           selectedImage: nil)
        
        let heroNavigator = HeroNavigator(services: heroUseCaseProvider,
                                          servicesDetail: heroDetailUseCaseProvider,
                                          navigationController: heroNavigationController,
                                          storyBoard: storyboard)
        
        let itemNavigationController = UINavigationController()
        itemNavigationController.tabBarItem = UITabBarItem(title: "Item",
                                                           image: UIImage(systemName: "pencil.slash"),
                                                           selectedImage: nil)
        
        let itemNavigator = ItemNavigator(services: itemUseCaseProvider,
                                          servicesDetail: itemDetailUseCaseProvider,
                                          navigationController: itemNavigationController,
                                          storyBoard: storyboard)
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                              image: UIImage(named: "profile_icon"),
                                                              selectedImage: nil)
        
        let profileNavigator = ProfileNavigator(profileService: profileUseCaseProvider,
                                                registerService: registerUseCaseProvider,
                                                storyBoard: storyboard,
                                                navigationController: profileNavigationController)
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [patchNavigationController,
                                            heroNavigationController,
                                            itemNavigationController,
                                            profileNavigationController]
        
        window.rootViewController = tabbarController
        
        configureTabBar(tabbarController: tabbarController)
        
        patchNavigator.toPatch()
        heroNavigator.toHero()
        itemNavigator.toItem()
        profileNavigator.toProfile()
    }
    
    func configureTabBar(tabbarController: UITabBarController) {
        tabbarController.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        tabbarController.tabBar.tintColor = UIColor.link
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 75/255.0, green: 75/255.0, blue: 75/255.0, alpha: 0.25)
            tabbarController.tabBar.scrollEdgeAppearance = appearance
            tabbarController.tabBar.standardAppearance = appearance
        }
    }
    
}
