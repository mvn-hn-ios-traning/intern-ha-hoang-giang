//
//  HeroDetailUseCaseProviderDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Hero Detail
public protocol HeroDetailUseCaseProviderDomain {
    func makeHeroDetailUseCase() -> HeroDetailUseCaseDomain
}
