//
//  AttributeViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 28/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct AttributeViewModel {
    static let shared = AttributeViewModel()
    let listAttribute = BehaviorRelay<[String]>(value: ["strengthIcon", "agiIcon", "intelIcon"])
}
