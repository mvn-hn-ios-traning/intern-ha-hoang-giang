//
//  ProfileViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    var profileViewModel: ProfileViewModel!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = ProfileViewModel.Input(tappedLogin: loginButton.rx.tap.asDriver())
        
        let output = profileViewModel.transform(input: input)
        
        output.tappedLoginOutput.drive().disposed(by: disposeBag)
    }
    
}
