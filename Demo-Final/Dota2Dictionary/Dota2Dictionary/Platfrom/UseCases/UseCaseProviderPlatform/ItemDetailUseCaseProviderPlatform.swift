//
//  ItemDetailUseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Item Detail
public final class ItemDetailUseCaseProviderPlatform: ItemDetailUseCaseProviderDomain {
    public func makeItemDetailUseCase() -> ItemDetailUseCaseDomain {
        return ItemDetailUseCasePlatform()
    }
}
