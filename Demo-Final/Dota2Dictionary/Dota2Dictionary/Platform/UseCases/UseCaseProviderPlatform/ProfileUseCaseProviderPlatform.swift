//
//  ProfileUseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 18/11/2021.
//

import Foundation

class ProfileUseCaseProviderPlatform: ProfileUseCaseProviderDomain {
    func makeProfileUseCase() -> ProfileUseCaseDomain {
        return ProfileUseCasePlatform()
    }
}
 
