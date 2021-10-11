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
    
    private init() {
        self.patchUseCaseProvider = PatchUseCaseProviderPlatform()
    }
    
    func configureMainInterface() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let patchNavigationController = UINavigationController()
        
        let patchNavigator = DefaultPatchNavigator(services: patchUseCaseProvider,
                                                   navigationController: patchNavigationController,
                                                   storyBoard: storyboard)
        patchNavigator.toPatch()
    }
    
}
