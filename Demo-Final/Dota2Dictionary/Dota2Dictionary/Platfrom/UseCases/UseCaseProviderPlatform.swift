//
//  UseCaseProviderPlatform.swift
//  Dota2Dictionary
//
//  Created by MacOS on 11/10/2021.
//

import Foundation

public final class PatchUseCaseProviderPlatform: PatchUseCaseProviderDomain {
    public func makePatchUseCase() -> PatchDetailUseCaseDomain {
        return PatchDetailUseCasePlatform()
    }
}

public final class HeroUseCaseProviderPlatform: HeroUseCaseProviderDomain {
    public func makeHeroUseCase() -> HeroUseCaseDomain {
        return HeroUseCasePlatform()
    }
}

public final class ItemUseCaseProviderPlatform: ItemUseCaseProviderDomain {
    public func makeItemUseCase() -> ItemUseCaseDomain {
        return ItemUseCasePlatform()
    }
}

public final class ItemDetailUseCaseProviderPlatform: ItemDetailUseCaseProviderDomain {
    public func makeItemDetailUseCase() -> ItemDetailUseCaseDomain {
        return ItemDetailUseCasePlatform()
    }
}
