//
//  UseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import Foundation
import RxSwift

// MARK: - Patch
public protocol PatchUseCaseDomain {
    func loadPatchDataAllFirst() -> Observable<[PatchModel]>
}
