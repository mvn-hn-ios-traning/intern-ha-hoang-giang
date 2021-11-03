//
//  HeroDetailViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HeroDetailViewController: UIViewController {
    
    @IBOutlet weak var heroDetailTableView: UITableView!
    
    let disposeBag = DisposeBag()

    var heroDetailViewModel: HeroDetailViewModel!
    
    let dataSource = HeroDetailDataSource.dataSource()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = HeroDetailViewModel.Input(firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()))
        
        let output = heroDetailViewModel.transform(input: input)
        
        output
            .firstLoadingOutput
            .drive()
            .disposed(by: disposeBag)
        output
            .rolesData
            .drive()
            .disposed(by: disposeBag)
        
        output
            .cellDatas
            .bind(to: heroDetailTableView
                    .rx
                    .items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}
