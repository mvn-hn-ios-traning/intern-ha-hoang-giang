//
//  UseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxSwift

public protocol HeroUseCaseDomain {
    func loadStrengthData() -> Observable<[HeroModel]>
    func loadAgibilityData() -> Observable<[HeroModel]>
    func loadIntelligentData() -> Observable<[HeroModel]>
}

