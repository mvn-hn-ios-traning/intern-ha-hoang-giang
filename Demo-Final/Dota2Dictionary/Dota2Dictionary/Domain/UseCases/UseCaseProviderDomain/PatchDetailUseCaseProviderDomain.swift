//
//  PatchDetailUseCaseProviderDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Patch Detail
public protocol PatchDetailUseCaseProviderDomain {
    func makePatchDetailUseCase() -> PatchDetailUseCaseDomain
}
