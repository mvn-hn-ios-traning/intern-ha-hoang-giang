//
//  UseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 11/10/2021.
//

import Foundation

public final class PatchUseCaseProviderPlatform: PatchUseCaseProviderDomain {
    
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makePatchUseCase() -> PatchDetailUseCaseDomain {
        return PatchDetailUseCasePlatform()
    }
    
}
