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

// MARK: - Patch Detal
public final class PatchDetailUseCaseProviderPlatform: PatchDetailUseCaseProviderDomain {
    public func makePatchDetailUseCase() -> PatchDetailUseCaseDomain {
        return PatchDetailUseCasePlatform()
    }
}

// MARK: - Hero
public final class HeroUseCaseProviderPlatform: HeroUseCaseProviderDomain {
    public func makeHeroUseCase() -> HeroUseCaseDomain {
        return HeroUseCasePlatform()
    }
}

// MARK: - Hero Detail
public final class HeroDetailUseCaseProviderPlatform: HeroDetailUseCaseProviderDomain {
    public func makeHeroDetailUseCase() -> HeroDetailUseCaseDomain {
        return HeroDetailUseCasePlatform()
    }
}

// MARK: - Item
public final class ItemUseCaseProviderPlatform: ItemUseCaseProviderDomain {
    public func makeItemUseCase() -> ItemUseCaseDomain {
        return ItemUseCasePlatform()
    }
}

// MARK: - Item Detail
public final class ItemDetailUseCaseProviderPlatform: ItemDetailUseCaseProviderDomain {
    public func makeItemDetailUseCase() -> ItemDetailUseCaseDomain {
        return ItemDetailUseCasePlatform()
    }
}
