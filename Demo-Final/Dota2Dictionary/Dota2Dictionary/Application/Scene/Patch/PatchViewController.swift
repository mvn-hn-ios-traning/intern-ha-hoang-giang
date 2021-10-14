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
    let patchTableViewCell = "PatchTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        patchTableView.register(UINib(nibName: patchTableViewCell,
                                      bundle: nil),
                                forCellReuseIdentifier: patchTableViewCell)
        bindViewModel()
        customTabBarAndNavigation()
    }
    
    func bindViewModel() {
        patchViewModel
            .listPatchNew
            .bind(to: patchTableView
                    .rx
                    .items(cellIdentifier: patchTableViewCell,
                           cellType: PatchTableViewCell.self)) { (_, element, cell) in
                cell.patchName.text = "Version: " + element.newPatchName
                cell.generalDetail.text = element.newGeneral
            }
            .disposed(by: disposeBag)
        
        patchTableView
            .rx
            .modelSelected(NewPatchDetailViewModel.self)
            .subscribe(onNext: { [weak self] object in
                guard let self = self else { return }
                
                if let selectedRowIndexPath = self.patchTableView.indexPathForSelectedRow {
                    self.patchTableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let viewController = storyboard
                        .instantiateViewController(withIdentifier: "PatchDetailViewController")
                        as? PatchDetailViewController else {
                    return
                }
                viewController.title = object.newPatchName
                viewController.patchDetailViewModel = PatchDetailViewModel(patchName: object.patchName)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func customTabBarAndNavigation() {
        // Navigation Bar:
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        // Navigation Bar Text:
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        // Tab Bar:
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        // Tab Bar Text:
        tabBarController?.tabBar.tintColor = UIColor.link
    }
    
}
