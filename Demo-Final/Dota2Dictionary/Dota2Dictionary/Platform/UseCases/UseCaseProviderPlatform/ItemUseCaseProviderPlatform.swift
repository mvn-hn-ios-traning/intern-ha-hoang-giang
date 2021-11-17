//
//  ItemUseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation

// MARK: - Item
public final class ItemUseCaseProviderPlatform: ItemUseCaseProviderDomain {
    public func makeItemUseCase() -> ItemUseCaseDomain {
        return ItemUseCasePlatform()
    }
}
