//
//  DefaultPatchNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 11/10/2021.
//

import UIKit

protocol DefaultPatchNavigator {
    func toPatch()
    func toPatchDetail()
}

class PatchNavigator: DefaultPatchNavigator {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: PatchUseCaseProviderDomain
    
    init(services: PatchUseCaseProviderDomain,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toPatch() {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "PatchViewController")
                as? PatchViewController else {
            return
        }
        viewController.patchViewModel = PatchViewModel()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toPatchDetail() {
        
    }
}
