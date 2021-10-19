//
//  UseCaseProviderDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 11/10/2021.
//

import Foundation

// MARK: - Patch
public protocol PatchUseCaseProviderDomain {
    func makePatchUseCase() -> PatchUseCaseDomain
}

// MARK: - Patch Detail
public protocol PatchDetailUseCaseProviderDomain {
    func makePatchDetailUseCase() -> PatchDetailUseCaseDomain
}

// MARK: - Hero
public protocol HeroUseCaseProviderDomain {
    func makeHeroUseCase() -> HeroUseCaseDomain
}

// MARK: - Hero Detail
public protocol HeroDetailUseCaseProviderDomain {
    func makeHeroDetailUseCase() -> HeroDetailUseCaseDomain
}

// MARK: - Item All
public protocol ItemUseCaseProviderDomain {
    func makeItemUseCase() -> ItemUseCaseDomain
}

// MARK: - Item Detail
public protocol ItemDetailUseCaseProviderDomain {
    func makeItemDetailUseCase() -> ItemDetailUseCaseDomain
}
