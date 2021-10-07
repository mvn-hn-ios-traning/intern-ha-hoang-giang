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
    let disposeBag = DisposeBag()
    
    var patchDetailViewModel: PatchDetailViewModel!

    @IBOutlet weak var selectHeroesPatch: UIButton!
    @IBOutlet weak var selectItemsPatch: UIButton!
    @IBOutlet weak var patchDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patchDetailTableView.register(UINib(nibName: "PatchDetailTableViewCell",
                                            bundle: nil),
                                      forCellReuseIdentifier: "PatchDetailTableViewCell")
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func bindViewModel() {
        
        let input = PatchDetailViewModel.Input(heroesPatchSelecting: selectHeroesPatch.rx.tap.asDriver(),
                                               itemsPatchSelecting: selectItemsPatch.rx.tap.asDriver(),
                                               trigger: self.rx.viewWillAppear.map({ _ in
                                               }).asDriver(onErrorJustReturn: Void()))
        
        let output = patchDetailViewModel.transform(input: input)
        
        output.fetchOutput
            .bind(to: patchDetailTableView
                    .rx
                    .items(cellIdentifier: "PatchDetailTableViewCell",
                           cellType: PatchDetailTableViewCell.self)) {  _, detail, cell in
                cell.configure(model: detail)
            }
            .disposed(by: disposeBag)
    }
    
}
