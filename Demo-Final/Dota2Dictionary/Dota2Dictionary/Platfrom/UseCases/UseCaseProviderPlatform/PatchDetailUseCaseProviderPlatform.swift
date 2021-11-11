//
//  PatchDetailUseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Patch Detal
public final class PatchDetailUseCaseProviderPlatform: PatchDetailUseCaseProviderDomain {
    public func makePatchDetailUseCase() -> PatchDetailUseCaseDomain {
        return PatchDetailUseCasePlatform()
    }
}
