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
import Firebase

class HeroDetailViewController: UIViewController {
    
    @IBOutlet weak var heroDetailTableView: UITableView!
    @IBOutlet weak var likeButton: UIBarButtonItem!
    
    let disposeBag = DisposeBag()
    
    var heroDetailViewModel: HeroDetailViewModel!
    
    let dataSource = HeroDetailDataSource.dataSource()
    
    var oldTabbarFr: CGRect = .zero
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        bindViewModel()
        oldTabbarFr = self.tabBarController?.tabBar.frame ?? .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.frame = .zero
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.frame = oldTabbarFr
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
    
    // MARK: - bind view model
    func bindViewModel() {
        let input = HeroDetailViewModel.Input(firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()),
                                              likeTapped: likeButton.rx.tap.asDriver())
        
        let output = heroDetailViewModel.transform(input: input)
        
        output
            .cellDatas
            .bind(to: heroDetailTableView
                    .rx
                    .items(dataSource: dataSource))
            .disposed(by: disposeBag)
                
        output
            .uploadedData
            .drive()
            .disposed(by: disposeBag)
        
        output
            .likeTitle
            .map({ string -> UIImage? in
                if let image = UIImage(named: string) {
                    return image
                } else {
                    return nil
                }
            })
            .bind(to: self.likeButton.rx.image)
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
