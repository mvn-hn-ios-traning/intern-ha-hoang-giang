//
//  HeroViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 27/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class HeroViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    
    var listHero = BehaviorRelay<[HeroModel]>(value: [])
    
    override init() {
        super.init()
        bindingData()
    }
    
    func bindingData() {
        Network.shared.getHeroAll { [weak self] data, _ in
            if let data = data {
                self?.listHero.accept(data)
            }
        }
    }
    
}
