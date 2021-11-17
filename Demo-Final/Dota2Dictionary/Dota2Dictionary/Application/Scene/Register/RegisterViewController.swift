//
//  RegisterViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Toast_Swift

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    var style: ToastStyle {
        var style = ToastStyle()
        style.backgroundColor = .darkGray
        return style
    }
    
    var registerViewModel: RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToastManager.shared.style = style
        bindViewModel()
    }
    
    func bindViewModel() {
        
        let input = RegisterViewModel.Input(enteredEmail: emailTextField.rx.text.orEmpty.asDriver(),
                                            enteredPassword: passwordTextField.rx.text.orEmpty.asDriver(),
                                            tappedRegister: registerButton.rx.tap.asDriver())
        let output = registerViewModel.transform(input: input)
        
        output
            .enableRegister
            .drive(registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output
            .tappedRegister
            .bind(onNext: { [weak self] text in
                guard let self = self else { return }
                
                self.view.endEditing(true)
                self.view.makeToast(text, position: .top)
            })
            .disposed(by: disposeBag)
    }
    
}
