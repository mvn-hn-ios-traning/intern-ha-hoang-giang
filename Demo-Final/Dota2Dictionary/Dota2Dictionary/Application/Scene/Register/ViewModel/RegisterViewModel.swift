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

class RegisterViewModel: ViewModelType {
    
    private let navigator: DefaultRegisterNavigator
    
    init(navigator: DefaultRegisterNavigator) {
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let enableRegister =
            Driver
                .combineLatest(input.enteredEmail,
                               input.enteredPassword) {
                                return !$0.isEmpty
                                    && $0.contains("@")
                                    && $0.contains(".com")
                                    && !$1.isEmpty
        }
        
        let tappedRegister = Driver
            .combineLatest(input.enteredEmail,
                           input.enteredPassword)
            .withLatestFrom(input.tappedRegister) { text, _ in
                
                Auth.auth().createUser(withEmail: text.0, password: text.1) { (_, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        print("Register success")
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
