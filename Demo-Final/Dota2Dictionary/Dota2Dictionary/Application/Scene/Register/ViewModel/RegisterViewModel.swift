//
//  RegisterViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 16/11/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import Toast_Swift

class RegisterViewModel: ViewModelType {
    
    private let navigator: DefaultRegisterNavigator
    private let viewController: RegisterViewController
    
    init(navigator: DefaultRegisterNavigator,
         viewController: RegisterViewController) {
        self.navigator = navigator
        self.viewController = viewController
    }
    
    func transform(input: Input) -> Output {
        
        let enableRegister = Driver
            .combineLatest(input.enteredEmail,
                           input.enteredPassword) {
                            return !$0.isEmpty
                                && $0.contains("@")
                                && $0.contains(".com")
                                && !$1.isEmpty
                                && $1.count >= 8
        }
        
        let mergeText = Driver.combineLatest(input.enteredEmail,
                                             input.enteredPassword)
        
        let tappedRegister = input
            .tappedRegister
            .withLatestFrom(mergeText) { [weak self] _, text in
                guard let self = self else {return}
                var style = ToastStyle()
                style.backgroundColor = .darkGray
                ToastManager.shared.style = style
                
                self.viewController.view.endEditing(true)
                Auth.auth().createUser(withEmail: text.0, password: text.1) { (_, error) in
                    if error != nil {
                        self.viewController.view.makeToast(error!.localizedDescription,
                                                           position: .top)
                    } else {
                        self.viewController.view.makeToast("Sign up successful",
                                                           position: .top)
                    }
                }
        }
        
        return Output(enableRegister: enableRegister,
                      tappedRegister: tappedRegister)
    }
}

extension RegisterViewModel {
    struct Input {
        let enteredEmail: Driver<String>
        let enteredPassword: Driver<String>
        let tappedRegister: Driver<Void>
    }
    
    struct Output {
        let enableRegister: Driver<Bool>
        let tappedRegister: Driver<Void>
    }
}
