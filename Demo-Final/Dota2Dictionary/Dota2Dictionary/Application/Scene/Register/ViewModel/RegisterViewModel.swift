//
//  RegisterViewModel.swift
//  Dota2Dictionary
//
//  Created by MacOS on 16/11/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Toast_Swift

class RegisterViewModel: ViewModelType {
    
    private let navigator: DefaultRegisterNavigator
    
    init(navigator: DefaultRegisterNavigator) {
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let tappedRegisterOutput = Driver.combineLatest(input.enteredEmail,
                                                        input.enteredPassword) {
                                                            return !$0.isEmpty && !$1.isEmpty
        }
        
        return Output(tappedRegisterOutput: tappedRegisterOutput)
    }
}

extension RegisterViewModel {
    struct Input {
        let enteredEmail: Driver<String>
        let enteredPassword: Driver<String>
        let tappedRegister: Driver<Void>
    }
    
    struct Output {
        let tappedRegisterOutput: Driver<Bool>
    }
}
