//
//  UseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxSwift

// MARK: - Hero
public protocol HeroUseCaseDomain {
    func loadStrengthData() -> Observable<[HeroModel]>
    func loadAgibilityData() -> Observable<[HeroModel]>
    func loadIntelligentData() -> Observable<[HeroModel]>
}

// MARK: - PatchDetail
public protocol PatchDetailUseCaseDomain {
    func loadHeroesPatchData(patchVersion: String) -> Observable<[PatchModel]>
    func loadItemsPatchData(patchVersion: String) -> Observable<[PatchModel]>
}
