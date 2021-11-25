//
//  ProfileUseCaseProviderDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 18/11/2021.
//

import Foundation

public protocol ProfileUseCaseProviderDomain {
    func makeProfileUseCase() -> ProfileUseCaseDomain
}
