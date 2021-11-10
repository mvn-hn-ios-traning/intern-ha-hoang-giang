//
//  HeroUseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Hero
public final class HeroUseCaseProviderPlatform: HeroUseCaseProviderDomain {
    public func makeHeroUseCase() -> HeroUseCaseDomain {
        return HeroUseCasePlatform()
    }
}
