//
//  HeroDetailViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 08/10/2021.
//

import UIKit
import RxSwift
import RxCocoa

class HeroDetailViewController: UIViewController {

    @IBOutlet weak var heroName: UILabel!
    
    let disposeBag = DisposeBag()

    private var heroDetailViewModel: HeroDetailViewModel = HeroDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
