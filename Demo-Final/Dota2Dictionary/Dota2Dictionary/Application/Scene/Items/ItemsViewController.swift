//
//  ItemsViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import UIKit
import RxCocoa
import RxSwift

class ItemsViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let itemViewModel = ItemViewModel()
    
    @IBOutlet weak var itemAllCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBarColor()
        
        itemAllCollectionView.register(UINib(nibName: "ItemsAllCollectionViewCell",
                                             bundle: nil),
                                       forCellWithReuseIdentifier: "ItemsAllCollectionViewCell")
        
        bindUI()
    }
    
    func bindUI() {
        self.itemViewModel.listArrayItem
            .bind(to: itemAllCollectionView
                    .rx
                    .items(cellIdentifier: "ItemsAllCollectionViewCell",
                           cellType: ItemsAllCollectionViewCell.self)) { (_, element, cell) in
                cell.bind(element)
            }
            .disposed(by: disposeBag)
        
        itemAllCollectionView.rx.modelSelected(String.self)
            .subscribe(onNext: { [weak self] object in
                
                guard let self = self else { return }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let viewController = storyboard
                        .instantiateViewController(withIdentifier: "ItemDetailViewController")
                        as? ItemDetailViewController else {
                    return
                }
                viewController.title = object.replacingOccurrences(of: "_", with: " ").capitalized
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }).disposed(by: disposeBag)
                
        itemAllCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func configureNaviBarColor() {
        // Navigation Bar:
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        // Navigation Bar Text:
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3.5, height: view.frame.size.height/6.5)
    }
}
