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
import Firebase

class HeroDetailViewModel: ViewModelType {
    
    let heroID: String
    let heroNameOriginal: String
    
    private let useCase: HeroDetailUseCaseDomain
    
    init(heroID: String,
         heroNameOriginal: String,
         useCase: HeroDetailUseCaseDomain) {
        self.heroID = heroID
        self.heroNameOriginal = heroNameOriginal
        self.useCase = useCase
    }
    
    // MARK: - Life Cycle
    func transform(input: Input) -> Output {
        
        let loadingALlData = Observable
            .zip(self.useCase.loadHeroDetailDataAtFirst(heroID: self.heroID),
                 self.useCase.loadHeroAbilityId(heroNameOriginal: self.heroNameOriginal),
                 self.useCase.loadHeroAbilities(),
                 self.useCase.loadHeroLore())
            .map { HeroDetailViewModelPlus(hero: $0.0,
                                           ability: $0.1,
                                           abilitiesDetail: $0.2,
                                           lore: $0.3)}
        
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
        
        let changingLikeTittle = input.firstLoading.asObservable().flatMap {
            self.useCase.changeLikeTitle(heroID: self.heroID) }
        
        let tappedLikeCheck = input.likeTapped
            .scan(false) { (lastState, _) in
                return !lastState
        }
        
        let uploadedDataOutput = tappedLikeCheck
            .withLatestFrom(loadingALlData.asDriver(onErrorDriveWith: .empty())) { state, data in
                self.useCase.like(heroID: self.heroID,
                                  state: state,
                                  data: data)
        }
        
        return Output(cellDatas: cellDatas,
                      uploadedData: uploadedDataOutput,
                      likeTitle: changingLikeTittle)
    }
}

// MARK: - Input Output
extension HeroDetailViewModel {
    struct Input {
        let firstLoading: Driver<Void>
        let likeTapped: Driver<Void>
    }
    
    struct Output {
        let cellDatas: Observable<[HeroDetailTableViewSection]>
        let uploadedData: Driver<Void>
        let likeTitle: Observable<String>
    }
}
