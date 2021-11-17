//
//  LoginViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 16/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewModel: ViewModelType {
    
    private let useCase: LoginUseCaseDomain
    private let navigator: DefaultLoginNavigator
    
    init(useCase: LoginUseCaseDomain,
         navigator: DefaultLoginNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let tappedRegisterOutput = input
            .tappedRegister
            .do(onNext: {
                self.navigator.toRegister()
            })
        
        let resetPassword = input
            .forgotTrigger
            .asObservable()
            .flatMap { self.useCase.resetPassword(email: $0) }
        
        return Output(tappedRegisterOutput: tappedRegisterOutput,
                      resetOuput: resetPassword)
    }
    
}

extension LoginViewModel {
    struct Input {
        let tappedRegister: Driver<Void>
        let forgotTrigger: Driver<String>
    }
    
    struct Output {
        let tappedRegisterOutput: Driver<Void>
        let resetOuput: Observable<String>
    }
}
