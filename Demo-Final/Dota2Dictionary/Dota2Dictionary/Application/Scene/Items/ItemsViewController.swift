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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        itemSearchBar.delegate = self
        itemAllCollectionView.register(UINib(nibName: ConstantsForCell.itemsAllCollectionViewCell,
                                             bundle: nil),
                                       forCellWithReuseIdentifier: ConstantsForCell.itemsAllCollectionViewCell)
        bindViewModel()
        configureNavigateBar()
    }
    
    // MARK: - bind View Model
    func bindViewModel() {
        let input = ItemViewModel.Input(selection: itemAllCollectionView.rx.itemSelected.asDriver(),
                                        searchTrigger: itemSearchBar.rx.text.orEmpty.asDriver(),
                                        firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()))
        let output = itemViewModel.transform(input: input)
        
        output
            .searchOutput
            .bind(to: itemAllCollectionView
                    .rx
                    .items(cellIdentifier: ConstantsForCell.itemsAllCollectionViewCell,
                           cellType: ItemsAllCollectionViewCell.self)) { (_, element, cell) in
                cell.bind(element)
            }
            .disposed(by: disposeBag)
        
        output
            .selectedItem
            .drive()
            .disposed(by: disposeBag)
        
        itemAllCollectionView
            .rx
            .setDelegate(self)
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

// MARK: - DelegateFlowLayout
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

// MARK: - Configure search bar
extension ItemsViewController: UISearchBarDelegate {
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.itemSearchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.itemSearchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.itemSearchBar.endEditing(true)
    }
}
