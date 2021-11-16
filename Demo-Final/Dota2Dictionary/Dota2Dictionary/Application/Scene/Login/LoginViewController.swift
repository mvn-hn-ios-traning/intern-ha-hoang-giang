//
//  LoginViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = LoginViewModel.Input(tappedRegister: registerButton.rx.tap.asDriver())
        
        let output = loginViewModel.transform(input: input)
        
        output
            .tappedRegisterOutput
            .drive()
            .disposed(by: disposeBag)
    }
    
}
