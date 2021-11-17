//
//  LoginUseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 17/11/2021.
//

import Foundation

// MARK: - Login
class LoginUseCaseProviderPlatform: LoginUseCaseProviderDomain {
    func makeLoginUseCase() -> LoginUseCaseDomain {
        return LoginUseCasePlatform()
    }
}
