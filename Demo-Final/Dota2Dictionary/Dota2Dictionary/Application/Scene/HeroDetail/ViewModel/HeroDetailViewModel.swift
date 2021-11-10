//
//  HeroDetailViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class HeroDetailViewModel: ViewModelType {
    
    let heroID: String
    
    private let useCase: HeroDetailUseCaseDomain
    
    init(heroID: String,
         useCase: HeroDetailUseCaseDomain) {
        self.heroID = heroID
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        
        let loadingALlData = Observable
            .zip(self.useCase.loadHeroDetailDataAtFirst(heroID: self.heroID),
                 self.useCase.loadHeroDetailRoles(),
                 self.useCase.loadHeroAbilityId(),
                 self.useCase.loadHeroAbilities())
            .map { HeroDetailViewModelPlus(hero: $0.0,
                                           roles: $0.1,
                                           abilityIDs: $0.2,
                                           abilitiesDetail: $0.3)}
                                    
        let cellDatas = loadingALlData
            .asObservable()
            .map {
                [HeroDetailTableViewSection](arrayLiteral:
                                                .infoSection(items: [.heroInfoTableViewItem(info: $0)]),
                                             .rolesSection(items: [.heroRolesTableViewItem(roles: $0)]),
                                             .languageSection(items: [.heroLanguageTableViewItem(language: $0)]),
                                             .statSection(items: [.heroStatTableViewItem(stat: $0)]),
                                             .abilitiesSection(items: $0.abilitiesDetailResult
                                                                .map { .heroAbilitiesTableViewItem(abilities: $0) }),
                                             .talentsSection(items: [.heroTalentsTableViewItem(talents: $0)]),
                                             .loreSection(items: [.heroLoreTableViewItem(lore: $0)]))
            }
        
        return Output(cellDatas: cellDatas)
    }
}

extension HeroDetailViewModel {
    struct Input {
        let firstLoading: Driver<Void>
    }
    
    struct Output {
        let cellDatas: Observable<[HeroDetailTableViewSection]>
    }
}
