//
//  HeroRolesTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 19/10/2021.
//

import UIKit
import RxSwift
import RxCocoa

class HeroRolesTableViewCell: UITableViewCell {

    @IBOutlet weak var rolesCollectionView: UICollectionView!
    
    var roles = BehaviorSubject<[String]>(value: [])
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
        rolesCollectionView.register(UINib(nibName: ConstantsForCell.rolesCollectionViewCell,
                                           bundle: nil),
                                     forCellWithReuseIdentifier: ConstantsForCell.rolesCollectionViewCell)
    }
    
    func configure(_ viewModel: HeroDetailViewModelPlus) {
        guard let newRoles = viewModel.roles else {
            return
        }
        roles.onNext(newRoles)
        
        roles
            .asObserver()
            .bind(to: rolesCollectionView
                    .rx
                    .items(cellIdentifier: ConstantsForCell.rolesCollectionViewCell,
                           cellType: RolesCollectionViewCell.self)) { _, element, cell in
                cell.configure(role: element)
            }
            .disposed(by: disposeBag)
        
        rolesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
}

extension HeroRolesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columnsSpacing: CGFloat = 20
        let numberOfColumns: CGFloat = 3
        let width: CGFloat = (collectionView.bounds.width - (columnsSpacing * (numberOfColumns - 1)))/numberOfColumns
        
        return CGSize(width: width,
                      height: 50)
    }
}
