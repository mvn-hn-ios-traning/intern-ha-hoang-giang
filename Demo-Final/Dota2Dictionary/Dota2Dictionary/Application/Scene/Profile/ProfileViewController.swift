//
//  ProfileViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Firebase
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    var profileViewModel: ProfileViewModel!
    
    let disposeBag = DisposeBag()
    
    let dataSource = ProfileDataSource.dataSource()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigateBar()
        hideKeyboardWhenTappedAround()
        checkUserLoggedIn()
        tableViewRegister()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.barStyle = .black
    }
    
    func tableViewRegister() {
        profileTableView.register(UINib(nibName: ConstantsForCell.profileInfoTableViewCell,
                                        bundle: nil),
                                  forCellReuseIdentifier: ConstantsForCell.profileInfoTableViewCell)
        profileTableView.register(UINib(nibName: ConstantsForCell.profileSignOutTableViewCell,
                                        bundle: nil),
                                  forCellReuseIdentifier: ConstantsForCell.profileSignOutTableViewCell)
        profileTableView.register(UINib(nibName: ConstantsForCell.profileLikeTableViewCell,
                                        bundle: nil),
                                  forCellReuseIdentifier: ConstantsForCell.profileLikeTableViewCell)
    }
    
    func configureNavigateBar() {
        navigationController!.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
        navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
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
        
        [output.enableLogin.drive(loginButton.rx.isEnabled),
         output.tappedRegisterOutput.drive()]
            .forEach({$0.disposed(by: disposeBag)})
        
        output
            .tappedLoginOutput
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }
                self.view.endEditing(true)
                self.view.makeToast(text, position: .top)
            })
            .disposed(by: disposeBag)
                
        output
            .resetPasswordOuput
            .bind { [weak self] text in
                guard let self = self else { return }
                self.view.makeToast(text, position: .top) }
            .disposed(by: disposeBag)
        
        output
            .loginSuccess
            .asObservable()
            .bind { [weak self] state in
                guard let self = self else { return }
                self.loginView.isHidden = state
                self.profileTableView.reloadData()}
            .disposed(by: disposeBag)
        
        output
            .cellItems
            .bind(to: profileTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        profileTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func checkUserLoggedIn() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user?.isEmailVerified == true {
                if Auth.auth().currentUser != nil {
                    // User is signed in.
                    self.loginView.isHidden = true
                } else {
                    // No user is signed in.
                    self.loginView.isHidden = false
                }
            } else {
                self.loginView.isHidden = false
            }
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 64
        } else if indexPath.section == 2 {
            return 128
        } else {
            return 256
        }
    }
}
