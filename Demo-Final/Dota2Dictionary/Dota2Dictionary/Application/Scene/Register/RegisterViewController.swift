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
        let registerTrigger = registerButton.rx.tap.flatMap {
            return Observable<Void>.create { observer -> Disposable in
                self.view.makeToast("Success", position: .top) { _ in
                    observer.onNext(())
                }
                return Disposables.create()
            }
        }
        
        let input = RegisterViewModel.Input(enteredEmail: emailTextField.rx.text.orEmpty.asDriver(),
                                            enteredPassword: passwordTextField.rx.text.orEmpty.asDriver(),
                                            tappedRegister: registerTrigger.asDriver(onErrorJustReturn: Void()))
        let output = registerViewModel.transform(input: input)
        
        output
            .enableRegister
            .drive(registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output
            .tappedRegister
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
    
}
