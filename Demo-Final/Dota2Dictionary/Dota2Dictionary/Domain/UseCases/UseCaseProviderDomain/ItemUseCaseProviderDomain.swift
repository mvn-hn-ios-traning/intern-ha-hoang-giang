//
//  ItemUseCaseProviderDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Item All
public protocol ItemUseCaseProviderDomain {
    func makeItemUseCase() -> ItemUseCaseDomain
}
