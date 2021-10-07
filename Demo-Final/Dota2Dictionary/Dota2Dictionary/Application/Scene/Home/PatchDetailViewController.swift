//
//  PatchDetailViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 04/10/2021.
//

import UIKit
import RxCocoa
import RxSwift

class PatchDetailViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var patchDetailViewModel: PatchDetailViewModel!

    @IBOutlet weak var patchDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patchDetailTableView.register(UINib(nibName: "PatchDetailTableViewCell",
                                            bundle: nil),
                                      forCellReuseIdentifier: "PatchDetailTableViewCell")
        bindUI()
    }
    
    func bindUI() {
        patchDetailViewModel
            .listDetailsNew
            .bind(to: patchDetailTableView
                    .rx
                    .items(cellIdentifier: "PatchDetailTableViewCell",
                           cellType: PatchDetailTableViewCell.self)) { (_, element, cell) in
                
                cell.itemName.text = element.newItemName
                cell.itemDetail.text = element.newItemDetail
                cell.configure(model: element)
            }
            .disposed(by: disposeBag)
    }
}
