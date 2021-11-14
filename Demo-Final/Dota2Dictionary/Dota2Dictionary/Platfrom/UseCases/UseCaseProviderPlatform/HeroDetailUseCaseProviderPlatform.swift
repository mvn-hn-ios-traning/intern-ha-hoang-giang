//
//  HeroDetailUseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Hero Detail
public final class HeroDetailUseCaseProviderPlatform: HeroDetailUseCaseProviderDomain {
    public func makeHeroDetailUseCase() -> HeroDetailUseCaseDomain {
        return HeroDetailUseCasePlatform()
    }
}
