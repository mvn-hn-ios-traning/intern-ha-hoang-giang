//
//  ProfileViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    var profileViewModel: ProfileViewModel!
    
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLogin()
        bindViewModel()
        
    }
    
    // MARK: - Bind ViewModel
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
                                              style: .default,
                                              handler: { _ in
                                                if let name = alert.textFields?.first?.text {
                                                    observer.onNext(name)
                                                }
                }))
                self.present(alert, animated: true)
                return Disposables.create()
            }
        }
        
        let input = ProfileViewModel.Input(enteredEmail: emailTextField.rx.text.orEmpty.asDriver(),
                                           enteredPassword: passwordTextField.rx.text.orEmpty.asDriver(),
                                           tappedLogin: loginButton.rx.tap.asDriver(),
                                           tappedRegister: registerButton.rx.tap.asDriver(),
                                           forgotTrigger: forgotTrigger.asDriver(onErrorJustReturn: String()))
        
        let output = profileViewModel.transform(input: input)
        
        output
            .tappedLoginOutput
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                
                self.view.endEditing(true)
                self.view.makeToast(text, position: .top)
            })
            .disposed(by: disposeBag)
        
        output
            .tappedRegisterOutput
            .drive()
            .disposed(by: disposeBag)
        
        output
            .resetPasswordOuput
            .bind { self.view.makeToast($0, position: .top) }
            .disposed(by: disposeBag)
        
        output
            .loginSuccess
            .asObservable()
            .bind { self.loginView.isHidden = $0 }
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - Test signOut and autoLogin
    
    @IBAction func signOut(_ sender: Any) {
        try? Auth.auth().signOut()
        loginView.isHidden = false
        signOutButton.title = ""
    }
    
    func autoLogin() {
        let currentUserId = Auth.auth().currentUser?.uid
        if currentUserId != nil {
            print("auto login")
            loginView.isHidden = true
            signOutButton.title = "Sign Out"
        }
    }
    
}
