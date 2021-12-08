//
//  PatchDetailViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 04/10/2021.
//

import UIKit
import RxCocoa
import RxSwift
import RxViewController

class PatchDetailViewController: UIViewController {
    
    @IBOutlet weak var selectHeroesPatch: UIButton!
    @IBOutlet weak var selectItemsPatch: UIButton!
    @IBOutlet weak var patchDetailTableView: UITableView!
    
    var patchDetailViewModel: PatchDetailViewModel!
    
    let disposeBag = DisposeBag()
    
    var oldTabbarFr: CGRect = .zero
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        patchDetailTableView.register(UINib(nibName: ConstantsForCell.patchDetailTableViewCell,
                                            bundle: nil),
                                      forCellReuseIdentifier: ConstantsForCell.patchDetailTableViewCell)
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
    
    // MARK: - Bind ViewModel
    func bindViewModel() {
        let input = PatchDetailViewModel.Input(heroesPatchSelecting: selectHeroesPatch.rx.tap.asDriver(),
                                               itemsPatchSelecting: selectItemsPatch.rx.tap.asDriver(),
                                               firstLoading: Observable
                                                .just(Void())
                                                .asDriver(onErrorJustReturn: Void()))
        
        let output = patchDetailViewModel.transform(input: input)
        
        output
            .fetchOutput
            .bind(to: patchDetailTableView
                    .rx
                    .items(cellIdentifier: ConstantsForCell.patchDetailTableViewCell,
                           cellType: PatchDetailTableViewCell.self)) {  _, detail, cell in
                cell.configure(model: detail)
            }
            .disposed(by: disposeBag)
        
    }
    
}
