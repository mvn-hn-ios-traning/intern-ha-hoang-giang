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
