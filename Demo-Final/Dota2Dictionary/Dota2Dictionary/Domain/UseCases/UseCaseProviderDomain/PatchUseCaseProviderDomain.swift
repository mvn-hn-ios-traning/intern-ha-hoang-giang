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
