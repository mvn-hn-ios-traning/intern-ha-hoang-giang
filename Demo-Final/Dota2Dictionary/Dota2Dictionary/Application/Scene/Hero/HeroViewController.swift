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
    
    var heroViewModel = HeroViewModel()
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var strengthButton: UIButton!
    @IBOutlet weak var agibilityButton: UIButton!
    @IBOutlet weak var intelligentButton: UIButton!
    
    @IBOutlet weak var allHeroCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allHeroCollectionView.register(UINib(nibName: "AllHeroCollectionViewCell",
                                             bundle: nil),
                                       forCellWithReuseIdentifier: "AllHeroCollectionViewCell")
        bindViewModel()
        configureNaviBarColor()
    }

    func bindViewModel() {
        let input = HeroViewModel.Input(strengthSelecting: strengthButton.rx.tap.asDriver(),
                                        agibilitySelecting: agibilityButton.rx.tap.asDriver(),
                                        intelligentSelecting: intelligentButton.rx.tap.asDriver(),
                                        trigger: self.rx.viewWillAppear.map({ _ in
                                        }).asDriver(onErrorJustReturn: Void()))
        
        let output = heroViewModel.transform(input: input)
        output
            .fetchOutput
            .bind(to: allHeroCollectionView
                    .rx
                    .items(cellIdentifier: "AllHeroCollectionViewCell",
                           cellType: AllHeroCollectionViewCell.self)) { _, hero, cell in
                cell.bind(hero)
            }
            .disposed(by: disposeBag)
        
        allHeroCollectionView.rx.modelSelected(HeroItemViewModel.self)
            .subscribe(onNext: { [weak self] object in
                guard let self = self else { return }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let viewController = storyboard
                        .instantiateViewController(withIdentifier: "HeroDetailViewController")
                        as? HeroDetailViewController else {
                    return
                }
                viewController.title = "\(object.theID)"
                self.navigationController?.pushViewController(viewController, animated: true)
            }).disposed(by: disposeBag)
        
        allHeroCollectionView.rx.setDelegate(self).disposed(by: disposeBag)

    }
    
    func configureNaviBarColor() {
        // Navigation Bar:
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        // Navigation Bar Text:
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

extension HeroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3.5, height: view.frame.size.height/6.5)
    }
}
