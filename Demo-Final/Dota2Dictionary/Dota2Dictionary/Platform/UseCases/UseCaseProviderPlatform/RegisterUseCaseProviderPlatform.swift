//
//  RegisterUseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 17/11/2021.
//

import Foundation

// MARK: - Register
class RegisterUseCaseProviderPlatform: RegisterUseCaseProviderDomain {
    func makeRegisterUseCase() -> RegisterUseCaseDomain {
        return RegisterUseCasePlatform()
    }
}
