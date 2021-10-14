//
//  UseCaseProviderDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 11/10/2021.
//

import Foundation

public protocol PatchUseCaseProviderDomain {
    func makePatchUseCase() -> PatchDetailUseCaseDomain
}

public protocol HeroUseCaseProviderDomain {
    func makeHeroUseCase() -> HeroUseCaseDomain
}

public protocol ItemUseCaseProviderDomain {
    func makeItemUseCase() -> ItemUseCaseDomain
}

public protocol ItemDetailUseCaseProviderDomain {
    func makeItemDetailUseCase() -> ItemDetailUseCaseDomain
}
