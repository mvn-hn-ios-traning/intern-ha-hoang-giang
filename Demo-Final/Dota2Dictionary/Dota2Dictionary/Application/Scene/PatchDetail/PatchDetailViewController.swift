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
    let patchDetailTableViewCell = "PatchDetailTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patchDetailTableView.register(UINib(nibName: patchDetailTableViewCell,
                                            bundle: nil),
                                      forCellReuseIdentifier: patchDetailTableViewCell)
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func bindViewModel() {
        
        let input = PatchDetailViewModel.Input(heroesPatchSelecting: selectHeroesPatch.rx.tap.asDriver(),
                                               itemsPatchSelecting: selectItemsPatch.rx.tap.asDriver(),
                                               firstLoading: self.rx.viewWillAppear.map({ _ in
                                               }).asDriver(onErrorJustReturn: Void()))
        
        let output = patchDetailViewModel.transform(input: input)
        
        output.fetchOutput
            .bind(to: patchDetailTableView
                    .rx
                    .items(cellIdentifier: patchDetailTableViewCell,
                           cellType: PatchDetailTableViewCell.self)) {  _, detail, cell in
                cell.configure(model: detail)
            }
            .disposed(by: disposeBag)
    }
    
}
