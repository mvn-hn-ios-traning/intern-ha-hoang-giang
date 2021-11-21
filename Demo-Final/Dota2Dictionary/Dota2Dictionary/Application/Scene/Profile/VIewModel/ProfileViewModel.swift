//
//  ProfileViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 15/11/2021.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel: ViewModelType {
    
    private let useCase: ProfileUseCaseDomain
    private let navigator: DefaultProfileNavigator
    
    init(useCase: ProfileUseCaseDomain,
         navigator: DefaultProfileNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let mergeText = Driver.combineLatest(input.enteredEmail, input.enteredPassword)
        
        let tappedLoginOutput = input
            .tappedLogin
            .withLatestFrom(mergeText) { _, text in
                self.useCase.login(email: text.0, password: text.1) }
            .asObservable()
            .flatMap {$0}
            .asDriver(onErrorDriveWith: .empty())
            .do(onNext: { text in
                if text == "Login successfully" {
                    self.navigator.toProfile()
                }
            })
        
        let tappedRegisterOutput = input
            .tappedRegister
            .do(onNext: {
                self.navigator.toRegister()
            })
        
        let resetPassword = input
            .forgotTrigger
            .asObservable()
            .flatMap { self.useCase.resetPassword(email: $0) }
        
        return Output(tappedLoginOutput: tappedLoginOutput,
                      tappedRegisterOutput: tappedRegisterOutput,
                      resetPasswordOuput: resetPassword)
    }
    
}

extension ProfileViewModel {
    struct Input {
        let enteredEmail: Driver<String>
        let enteredPassword: Driver<String>
        let tappedLogin: Driver<Void>
        let tappedRegister: Driver<Void>
        let forgotTrigger: Driver<String>
    }
    
    struct Output {
        let tappedLoginOutput: Driver<String>
        let tappedRegisterOutput: Driver<Void>
        let resetPasswordOuput: Observable<String>
    }
}
