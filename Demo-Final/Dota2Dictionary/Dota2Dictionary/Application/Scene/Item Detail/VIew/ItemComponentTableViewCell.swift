//
//  ItemComponentTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 01/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ItemComponentTableViewCell: UITableViewCell {
    @IBOutlet weak var itemComponentCollectionView: UICollectionView!
    
    var components = BehaviorSubject<[String]>(value: [])
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func registerCell() {
        itemComponentCollectionView.register(UINib(nibName: "ComponentCollectionViewCell",
                                                   bundle: nil),
                                             forCellWithReuseIdentifier: "ComponentCollectionViewCell")
    }
    
    func configure(_ viewModel: ItemDetailViewModelPlus) {
        components.onNext(viewModel.components)
        components
            .bind(to: itemComponentCollectionView
                    .rx
                    .items(cellIdentifier: "ComponentCollectionViewCell",
                           cellType: ComponentCollectionViewCell.self)) { _, element, cell in
                cell.configure(element)
            }
            .disposed(by: disposeBag)
        
        itemComponentCollectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension ItemComponentTableViewCell: UICollectionViewDelegateFlowLayout {
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
