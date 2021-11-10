//
//  ItemDetailViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/10/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var itemDetailTableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var itemDetailViewModel: ItemDetailViewModel!
    
    let dataSource = ItemDetailDataSource.dataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        bindViewModel()
        
    }
    
    func tableViewRegister() {
        itemDetailTableView.register(UINib(nibName: ConstantsForCell.infoTopTableViewCell,
                                     bundle: nil),
                               forCellReuseIdentifier: ConstantsForCell.infoTopTableViewCell)
        itemDetailTableView.register(UINib(nibName: ConstantsForCell.itemHintTableViewCell,
                                     bundle: nil),
                               forCellReuseIdentifier: ConstantsForCell.itemHintTableViewCell)
        itemDetailTableView.register(UINib(nibName: ConstantsForCell.manaColdownTableViewCell,
                                     bundle: nil),
                               forCellReuseIdentifier: ConstantsForCell.manaColdownTableViewCell)
        itemDetailTableView.register(UINib(nibName: ConstantsForCell.itemNotesTableViewCell,
                                     bundle: nil),
                               forCellReuseIdentifier: ConstantsForCell.itemNotesTableViewCell)
        itemDetailTableView.register(UINib(nibName: ConstantsForCell.itemAttribTableViewCell,
                                     bundle: nil),
                               forCellReuseIdentifier: ConstantsForCell.itemAttribTableViewCell)
        itemDetailTableView.register(UINib(nibName: ConstantsForCell.itemLoreTableViewCell,
                                     bundle: nil),
                               forCellReuseIdentifier: ConstantsForCell.itemLoreTableViewCell)
        itemDetailTableView.register(UINib(nibName: ConstantsForCell.itemComponentTableViewCell,
                                     bundle: nil),
                               forCellReuseIdentifier: ConstantsForCell.itemComponentTableViewCell)
    }
    
    func bindViewModel() {
        let input = ItemDetailViewModel.Input(loadAllDataAfterFilter: Observable
                                                .just(Void())
                                                .asDriver(onErrorJustReturn: Void()))
        let output = itemDetailViewModel.transform(input: input)
        
        output.allDataOutput.drive().disposed(by: disposeBag)
        
        output
            .dataForCell
            .bind(to: itemDetailTableView
                    .rx
                    .items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        itemDetailTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension ItemDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 6 {
            return CGFloat(250)
        } else {
            return UITableView.automaticDimension
        }
    }
}
