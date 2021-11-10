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
    
    // MARK: - Life Cycle
    func transform(input: Input) -> Output {
        let firstLoading = input
            .firstLoading
            .asObservable()
        
        let firstLoadingOutput = firstLoading
            .flatMapLatest {
                return self
                    .useCase
                    .loadHeroDetailDataAtFirst(heroID: self.heroID)
            }
            .map { HeroDetailViewModelPlus(with: $0) }
            .asDriver(onErrorDriveWith: .empty())
        
        let loadingRolesData = firstLoading
            .flatMapLatest {
                return self.useCase.loadHeroDetailRoles()
            }
            .asDriver(onErrorDriveWith: .empty())
        
        let items = firstLoadingOutput
            .asObservable()
            .map {
                [HeroDetailTableViewSection](arrayLiteral:
                                                .infoSection(items: [.heroInfoTableViewItem(info: $0)]),
                                             .rolesSection(items: $0
                                                            .roles
                                                            .map { HeroDetailTableViewItem
                                                                .heroRolesTableViewItem(roles: $0)}),
                                             .languageSection(items: [.heroLanguageTableViewItem(language: $0)]),
                                             .statSection(items: [.heroStatTableViewItem(stat: $0)]),
                                             .abilitiesSection(items: [.heroAbilitiesTableViewItem(abilities: $0)]),
                                             .talentsSection(items: [.heroTalentsTableViewItem(talents: $0)]))
            }
        
        return Output(firstLoadingOutput: firstLoadingOutput,
                      cellDatas: items,
                      rolesData: loadingRolesData)
    }
}

// MARK: - Input Output
extension HeroDetailViewModel {
    struct Input {
        let firstLoading: Driver<Void>
    }
    
    struct Output {
        let firstLoadingOutput: Driver<HeroDetailViewModelPlus>
        let cellDatas: Observable<[HeroDetailTableViewSection]>
        let rolesData: Driver<[RolesDetail]>
    }
}
