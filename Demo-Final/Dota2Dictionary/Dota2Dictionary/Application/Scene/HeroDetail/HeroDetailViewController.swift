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
    
    var checkLike: Bool = false

    var heroDetailViewModel: HeroDetailViewModel!
    
    let dataSource = HeroDetailDataSource.dataSource()
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        listenLike()
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
        let unlikeTapped = PublishSubject<Void>()
        let input = HeroDetailViewModel.Input(firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()),
                                              likeTapped: likeButton.rx.tap.asDriver(),
                                              unlikeTapped: unlikeTapped.asDriver(onErrorJustReturn: ()),
                                              check: checkLike)
        
        let output = heroDetailViewModel.transform(input: input)
        
        output
            .cellDatas
            .bind(to: heroDetailTableView
                    .rx
                    .items(dataSource: dataSource))
            .disposed(by: disposeBag)
                
        output.uploadedData.drive()
            .disposed(by: disposeBag)
        
        heroDetailTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func listenLike() {
        let ref = Database.database().reference()
        
        if let user = Auth.auth().currentUser {
            ref.child("liked").child(user.uid).child(heroDetailViewModel.heroID).observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.exists() {
                    self.checkLike = true
                } else {
                    self.checkLike = false
                }
            }
            
            ref.child("liked").child(user.uid).child(heroDetailViewModel.heroID).observe(.childAdded) { (_) in
                self.likeButton.title = "Unlike now"
            }
            ref.child("liked").child(user.uid).child(heroDetailViewModel.heroID).observe(.childRemoved) { (_) in
                self.likeButton.title = "Like pls"
            }
        }
        
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

enum LikeButtonState {
    case likeState
    case unlikeState
}

enum Action {
    case like
    case unlike
}
