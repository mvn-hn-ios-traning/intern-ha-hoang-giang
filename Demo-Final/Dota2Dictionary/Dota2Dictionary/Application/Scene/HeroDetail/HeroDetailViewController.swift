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
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        bindViewModel()
    }
    
    func tableViewRegister() {
        heroDetailTableView.register(UINib(nibName: ConstantsForCell.heroInfoTableViewCell,
                                 bundle: nil),
                           forCellReuseIdentifier: ConstantsForCell.heroInfoTableViewCell)
        
        heroDetailTableView.register(UINib(nibName: ConstantsForCell.heroRolesTableViewCell,
                                 bundle: nil),
                           forCellReuseIdentifier: ConstantsForCell.heroRolesTableViewCell)
        
        heroDetailTableView.register(UINib(nibName: ConstantsForCell.heroLanguageTableViewCell,
                                           bundle: nil),
                                     forCellReuseIdentifier: ConstantsForCell.heroLanguageTableViewCell)
        
        heroDetailTableView.register(UINib(nibName: ConstantsForCell.heroStatTableViewCell,
                                           bundle: nil),
                                     forCellReuseIdentifier: ConstantsForCell.heroStatTableViewCell)
        
        heroDetailTableView.register(UINib(nibName: ConstantsForCell.heroAbilitiesTableViewCell,
                                           bundle: nil),
                                     forCellReuseIdentifier: ConstantsForCell.heroAbilitiesTableViewCell)
        
        heroDetailTableView.register(UINib(nibName: ConstantsForCell.heroTalentsTableViewCell,
                                           bundle: nil),
                                     forCellReuseIdentifier: ConstantsForCell.heroTalentsTableViewCell)
        
        heroDetailTableView.register(UINib(nibName: ConstantsForCell.heroLoreTableViewCell,
                                           bundle: nil),
                                     forCellReuseIdentifier: ConstantsForCell.heroLoreTableViewCell)
    }
    
    func bindViewModel() {
        let input = HeroDetailViewModel.Input(firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()))
        
        let output = heroDetailViewModel.transform(input: input)
        
        output
            .cellDatas
            .bind(to: heroDetailTableView
                    .rx
                    .items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        heroDetailTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension HeroDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else if indexPath.section == 1 {
            return 50
        } else {
            return UITableView.automaticDimension
        }
    }
}
