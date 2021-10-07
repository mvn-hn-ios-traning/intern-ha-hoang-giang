//
//  ViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 22/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HomeViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var patchViewModel = PatchViewModel()
        
    @IBOutlet weak var patchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Patch Notes"
        customTabBarAndNavigation()
        patchTableView.register(UINib(nibName: "PatchTableViewCell",
                                      bundle: nil),
                                forCellReuseIdentifier: "PatchTableViewCell")
        bindUI()
    }
    
    func bindUI() {
        patchViewModel
            .listPatchNew
            .bind(to: patchTableView
                    .rx
                    .items(cellIdentifier: "PatchTableViewCell",
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
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard
                    .instantiateViewController(withIdentifier: "PatchDetailViewController")
                    as! PatchDetailViewController
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
