//
//  PatchViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class PatchViewController: UIViewController {
        
    @IBOutlet weak var patchTableView: UITableView!
    
    var patchViewModel: PatchViewModel!

    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patchTableView.register(UINib(nibName: ConstantsForCell.patchTableViewCell,
                                      bundle: nil),
                                forCellReuseIdentifier: ConstantsForCell.patchTableViewCell)
        bindViewModel()
        configureNavigateBar()
    }
    
    func bindViewModel() {
        let input = PatchViewModel.Input(firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()),
                                         selection: patchTableView.rx.itemSelected.asDriver())
        
        let output = patchViewModel.transform(input: input)
        
        output
            .firstLoadingOutput
            .asObservable()
            .bind(to: patchTableView
                    .rx
                    .items(cellIdentifier: ConstantsForCell.patchTableViewCell,
                           cellType: PatchTableViewCell.self)) { (_, element, cell) in
                cell.configure(element)
            }
            .disposed(by: disposeBag)
        
        output
            .selectedOutput
            .drive()
            .disposed(by: disposeBag)
    }
    
    func configureNavigateBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 75/255.0, green: 75/255.0, blue: 75/255.0, alpha: 0.25)
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]

        // Customizing our navigation bar
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}
