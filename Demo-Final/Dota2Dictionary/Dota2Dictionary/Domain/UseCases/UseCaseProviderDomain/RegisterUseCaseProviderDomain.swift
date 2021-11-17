//
//  RegisterUseCaseProviderDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 17/11/2021.
//

import Foundation

// MARK: - Register
public protocol RegisterUseCaseProviderDomain {
    func makeRegisterUseCase() -> RegisterUseCaseDomain
}
