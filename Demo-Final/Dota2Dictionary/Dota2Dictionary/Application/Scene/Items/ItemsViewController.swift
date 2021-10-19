//
//  ItemsViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import UIKit
import RxCocoa
import RxSwift
import RxViewController

class ItemsViewController: UIViewController {
    
    @IBOutlet weak var itemAllCollectionView: UICollectionView!
    @IBOutlet weak var itemSearchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    var itemViewModel: ItemViewModel!
    let itemsAllCollectionViewCell = "ItemsAllCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        itemAllCollectionView.register(UINib(nibName: itemsAllCollectionViewCell,
                                             bundle: nil),
                                       forCellWithReuseIdentifier: itemsAllCollectionViewCell)
        bindViewModel()
    }
    
    func bindViewModel() {
        
        let input = ItemViewModel.Input(firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()),
                                        selection: itemAllCollectionView.rx.itemSelected.asDriver(),
                                        searchTrigger: itemSearchBar.rx.text.orEmpty.asDriver())
        let output = itemViewModel.transform(input: input)
        output
            .firstLoadingOutput
            .bind(to: itemAllCollectionView
                    .rx
                    .items(cellIdentifier: itemsAllCollectionViewCell,
                           cellType: ItemsAllCollectionViewCell.self)) { (_, element, cell) in
                cell.bind(element)
            }
            .disposed(by: disposeBag)
        
        output
            .selectedItem
            .drive()
            .disposed(by: disposeBag)
        
        itemAllCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
}

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnsSpacing: CGFloat = 20
        let numberOfColumns: CGFloat = 3
        let width: CGFloat = (collectionView.bounds.width - (columnsSpacing * (numberOfColumns - 1)))/numberOfColumns
        
        return CGSize(width: width,
                      height: width)
    }
}
