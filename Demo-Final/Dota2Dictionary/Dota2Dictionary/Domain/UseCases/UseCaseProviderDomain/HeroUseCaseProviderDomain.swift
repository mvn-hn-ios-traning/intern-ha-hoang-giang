//
//  HeroUseCaseProviderDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Hero
public protocol HeroUseCaseProviderDomain {
    func makeHeroUseCase() -> HeroUseCaseDomain
}
