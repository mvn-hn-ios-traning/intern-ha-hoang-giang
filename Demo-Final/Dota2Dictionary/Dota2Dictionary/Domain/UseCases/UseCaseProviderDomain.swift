//
//  UseCaseProviderDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 24/09/2021.
//

import Foundation

public protocol HeroUseCaseProviderDomain {
    
    func makeHeroUseCaseDomain() -> HeroUseCaseDomain
}

