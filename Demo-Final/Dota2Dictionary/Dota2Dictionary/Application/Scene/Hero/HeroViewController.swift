//
//  HeroViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 27/09/2021.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa
import RxViewController

class HeroViewController: UIViewController {
    
    @IBOutlet weak var strengthButton: UIButton!
    @IBOutlet weak var agibilityButton: UIButton!
    @IBOutlet weak var intelligentButton: UIButton!
    @IBOutlet weak var allHeroCollectionView: UICollectionView!
        
    var heroViewModel: HeroViewModel!
    
    let disposeBag = DisposeBag()
    let allHeroCollectionViewCell = "AllHeroCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allHeroCollectionView.register(UINib(nibName: allHeroCollectionViewCell,
                                             bundle: nil),
                                       forCellWithReuseIdentifier: allHeroCollectionViewCell)
        bindViewModel()
    }
    
    func bindViewModel() {
        
        let input = HeroViewModel.Input(strengthSelecting: strengthButton.rx.tap.asDriver(),
                                        agibilitySelecting: agibilityButton.rx.tap.asDriver(),
                                        intelligentSelecting: intelligentButton.rx.tap.asDriver(),
                                        firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()),
                                        selection: allHeroCollectionView.rx.itemSelected.asDriver())
        
        let output = heroViewModel.transform(input: input)
        output
            .fetchOutput
            .bind(to: allHeroCollectionView
                    .rx
                    .items(cellIdentifier: allHeroCollectionViewCell,
                           cellType: AllHeroCollectionViewCell.self)) { _, hero, cell in
                cell.bind(hero)
            }
            .disposed(by: disposeBag)
        
        output.selectedOutput.drive().disposed(by: disposeBag)
        
        allHeroCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
}

extension HeroViewController: UICollectionViewDelegateFlowLayout {
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
