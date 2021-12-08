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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.barStyle = .black
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
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            navigationController!.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
            navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    
}
