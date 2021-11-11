//
//  PatchDetailUseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/11/2021.
//

import Foundation
import RxSwift

// MARK: - PatchDetail
public protocol PatchDetailUseCaseDomain {
    func loadHeroesPatchData(patchVersion: String) -> Observable<[PatchModel]>
    func loadItemsPatchData(patchVersion: String) -> Observable<[PatchModel]>
}
