//
//  LoginViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Toast_Swift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    var style: ToastStyle {
        var style = ToastStyle()
        style.backgroundColor = .darkGray
        return style
    }
    
    var loginViewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToastManager.shared.style = style
        bindViewModel()
    }
    
    func bindViewModel() {
        let forgotTrigger = forgotButton.rx.tap.flatMap {
            return Observable<String>.create { (observer) -> Disposable in
                let alert = UIAlertController(title: "Enter your email here",
                                              message: "Check email for reset password mail",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Cancel",
                                              style: .cancel,
                                              handler: nil))
                
                alert.addTextField(configurationHandler: { textField in
                    textField.placeholder = "Input your email here..."
                })
                
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default, handler: { _ in
                                                if let name = alert.textFields?.first?.text {
                                                    observer.onNext(name)
                                                }
                }))
                self.present(alert, animated: true)
                return Disposables.create()
            }
        }
        
        let input = LoginViewModel.Input(tappedRegister: registerButton.rx.tap.asDriver(),
                                         forgotTrigger: forgotTrigger.asDriver(onErrorJustReturn: String()))
        
        let output = loginViewModel.transform(input: input)
        
        output
            .tappedRegisterOutput
            .drive()
            .disposed(by: disposeBag)
        
        output
            .resetOuput
            .bind { self.view.makeToast($0, position: .top) }
            .disposed(by: disposeBag)
    }
    
}
