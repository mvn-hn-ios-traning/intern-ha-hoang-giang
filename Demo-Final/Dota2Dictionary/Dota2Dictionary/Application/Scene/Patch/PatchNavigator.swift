//
//  DefaultPatchNavigator.swift
//  Dota2Dictionary
//
//  Created by MacOS on 11/10/2021.
//

import UIKit

protocol DefaultPatchNavigator {
    func toPatch()
    func toPatchDetail(_ viewModel: NewPatchDetailViewModel)
}

class PatchNavigator: DefaultPatchNavigator {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: PatchUseCaseProviderDomain
    private let servicesDetail: PatchDetailUseCaseProviderDomain
    
    init(services: PatchUseCaseProviderDomain,
         servicesDetail: PatchDetailUseCaseProviderDomain,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.servicesDetail = servicesDetail
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toPatch() {
        guard let viewController = storyBoard
                .instantiateViewController(withIdentifier: "PatchViewController")
                as? PatchViewController else {
            return
        }
        viewController.patchViewModel = PatchViewModel(useCase: services.makePatchUseCase(),
                                                       navigator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toPatchDetail(_ viewModel: NewPatchDetailViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard
                .instantiateViewController(withIdentifier: "PatchDetailViewController")
                as? PatchDetailViewController else {
            return
        }
        viewController.patchDetailViewModel = PatchDetailViewModel(patchName: viewModel.patchName,
                                                                   useCase: servicesDetail.makePatchDetailUseCase())
        navigationController.pushViewController(viewController, animated: true)
    }
}
