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
    
    private let navigator: DefaultLoginNavigator
    
    init(navigator: DefaultLoginNavigator) {
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let tappedRegisterOutput = input
            .tappedRegister
            .do(onNext: navigator.toRegister)
        
        return Output(tappedRegisterOutput: tappedRegisterOutput)
    }
    
}

extension LoginViewModel {
    struct Input {
        let tappedRegister: Driver<Void>
    }
    
    struct Output {
        let tappedRegisterOutput: Driver<Void>
    }
}
