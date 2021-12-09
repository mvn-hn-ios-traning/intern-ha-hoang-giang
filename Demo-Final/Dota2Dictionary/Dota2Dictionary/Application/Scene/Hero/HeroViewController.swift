//
//  HeroViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 27/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class HeroViewController: UIViewController {
    
    @IBOutlet weak var strengthButton: UIButton!
    @IBOutlet weak var agibilityButton: UIButton!
    @IBOutlet weak var intelligentButton: UIButton!
    @IBOutlet weak var allHeroCollectionView: UICollectionView!
        
    var heroViewModel: HeroViewModel!
    
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        allHeroCollectionView.register(UINib(nibName: ConstantsForCell.allHeroCollectionViewCell,
                                             bundle: nil),
                                       forCellWithReuseIdentifier: ConstantsForCell.allHeroCollectionViewCell)
        bindViewModel()
        configureNavigateBar()
    }
    
    func bindViewModel() {
        let strBtn = strengthButton.rx.tap.map {HeroAttributeButton.str}
        let agiBtn = agibilityButton.rx.tap.map {HeroAttributeButton.agi}
        let intBtn = intelligentButton.rx.tap.map {HeroAttributeButton.int}
        
        let fetchBtn = Observable.of(strBtn, agiBtn, intBtn).merge()
        
        let input = HeroViewModel.Input(firstLoading: Observable.just(Void()).asDriver(onErrorJustReturn: Void()),
                                        selection: allHeroCollectionView.rx.itemSelected.asDriver(),
                                        fetchBtn: fetchBtn)
        
        let output = heroViewModel.transform(input: input)
        output
            .fetchOutput
            .asObservable()
            .bind(to: allHeroCollectionView
                    .rx
                    .items(cellIdentifier: ConstantsForCell.allHeroCollectionViewCell,
                           cellType: AllHeroCollectionViewCell.self)) { _, hero, cell in
                cell.bind(hero)
            }
            .disposed(by: disposeBag)
        
        output
            .selectedOutput
            .drive()
            .disposed(by: disposeBag)
        
        allHeroCollectionView
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

// MARK: - HeroAttributeButton
enum HeroAttributeButton: String {
    case str
    case agi
    case int
}
