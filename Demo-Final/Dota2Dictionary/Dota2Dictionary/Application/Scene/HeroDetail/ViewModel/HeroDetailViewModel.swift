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
        let firstLoadingOutput = input
            .firstLoading
            .asObservable()
            .flatMapLatest {
                return self
                    .useCase
                    .loadHeroDetailDataAtFirst(heroID: self.heroID)
            }
            .map { HeroDetailViewModelPlus(with: $0) }
            .asDriver(onErrorDriveWith: .empty())
        
        let items = BehaviorSubject<[HeroDetailTableViewSection]>(value: [
            .infoSection(items: [.heroInfoTableViewItem(info: HeroDetailViewModelPlus)])
        ])
        
        let dataSource = HeroDetailDataSource.dataSource()
        
        return Output(firstLoadingOutput: firstLoadingOutput,
                      dataSource: dataSource)
    }
}

extension HeroDetailViewModel {
    struct Input {
        let firstLoading: Driver<Void>
    }
    
    struct Output {
        let firstLoadingOutput: Driver<HeroDetailViewModelPlus>
        
        let dataSource: RxTableViewSectionedReloadDataSource<HeroDetailTableViewSection>
    }
}
