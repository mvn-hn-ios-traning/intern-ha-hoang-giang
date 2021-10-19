//
//  ItemDetailViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/10/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var itemAvatar: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var costValue: UILabel!
    @IBOutlet weak var hint: UILabel!
    @IBOutlet weak var manaCost: UILabel!
    @IBOutlet weak var coldown: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var attribute: UILabel!
    @IBOutlet weak var lore: UILabel!
    @IBOutlet weak var component: UICollectionView!
    
    let disposeBag = DisposeBag()
    
    var itemDetailViewModel: ItemDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        component.register(UINib(nibName: "ComponentCollectionViewCell",
                                 bundle: nil),
                           forCellWithReuseIdentifier: "ComponentCollectionViewCell")
        
        let input = ItemDetailViewModel.Input(firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()),
                                              avatarFirstLoading: Observable.just("").asDriver(onErrorJustReturn: ""),
                                              nameLoading: Observable.just("").asDriver(onErrorJustReturn: ""),
                                              costLoading: Observable.just("").asDriver(onErrorJustReturn: ""),
                                              hintLoading: Observable.just("").asDriver(onErrorJustReturn: ""),
                                              manaCostLoading: Observable.just("").asDriver(onErrorJustReturn: ""),
                                              coldownLoading: Observable.just("").asDriver(onErrorJustReturn: ""),
                                              notesLoading: Observable.just("").asDriver(onErrorJustReturn: ""),
                                              attributeLoading: Observable.just("").asDriver(onErrorJustReturn: ""),
                                              loreLoading: Observable.just("").asDriver(onErrorJustReturn: ""),
                                              componentLoading: Observable.just([""]).asDriver(onErrorJustReturn: [""]))
        
        let output = itemDetailViewModel.transform(input: input)
        
        output.firstLoadingOutput.asDriver(onErrorDriveWith: .empty()).drive().disposed(by: disposeBag)
        
        output.avatarOutput.asObservable().subscribe { element in
            if let urlString = element.element {
                let url = URL(string: urlString)
                self.itemAvatar.kf.setImage(with: url)
            }
        }.disposed(by: disposeBag)
        
        output.nameOutput.drive(itemName.rx.text).disposed(by: disposeBag)
        output.costOutput.drive(costValue.rx.text).disposed(by: disposeBag)
        output.hintOutput.drive(hint.rx.text).disposed(by: disposeBag)
        output.manaCostOutput.drive(manaCost.rx.text).disposed(by: disposeBag)
        output.coldownOutput.drive(coldown.rx.text).disposed(by: disposeBag)
        output.notesOutput.drive(notes.rx.text).disposed(by: disposeBag)
        output.attributeOutput.drive(attribute.rx.text).disposed(by: disposeBag)
        output.loreOutput.drive(lore.rx.text).disposed(by: disposeBag)
        
        output
            .componentOutput
            .asObservable()
            .bind(to: component
                    .rx
                    .items(cellIdentifier: "ComponentCollectionViewCell",
                           cellType: ComponentCollectionViewCell.self)) { _, component, cell in
                cell.bind(component)
            }
            .disposed(by: disposeBag)
        
        component.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension ItemDetailViewController: UICollectionViewDelegateFlowLayout {
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
