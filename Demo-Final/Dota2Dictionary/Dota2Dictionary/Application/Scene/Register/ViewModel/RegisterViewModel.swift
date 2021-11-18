//
//  RegisterViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 16/11/2021.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel: ViewModelType {
    
    private let useCase: RegisterUseCaseDomain
    private let navigator: DefaultRegisterNavigator
    
    init(useCase: RegisterUseCaseDomain,
         navigator: DefaultRegisterNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        
        let enableRegister = Driver
            .combineLatest(input.enteredEmail,
                           input.enteredPassword) {
                            return !$0.isEmpty
                                && !$1.isEmpty
                                && $1.count >= 8
        }
        
        let mergeText = Driver.combineLatest(input.enteredEmail,
                                             input.enteredPassword)
        
        let tappedRegister = input
            .tappedRegister
            .withLatestFrom(mergeText) { _, text -> Observable<String> in
                self.useCase.register(email: text.0, password: text.1) }
            .asObservable()
            .flatMap {$0}
        
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
        let tappedRegister: Observable<String>
    }
}
