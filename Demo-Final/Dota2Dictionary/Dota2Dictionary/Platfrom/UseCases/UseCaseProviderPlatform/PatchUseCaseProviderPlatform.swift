//
//  UseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 11/10/2021.
//

import Foundation

// MARK: - Patch
public final class PatchUseCaseProviderPlatform: PatchUseCaseProviderDomain {
    public func makePatchUseCase() -> PatchUseCaseDomain {
        return PatchUseCasePlatform()
    }
}
