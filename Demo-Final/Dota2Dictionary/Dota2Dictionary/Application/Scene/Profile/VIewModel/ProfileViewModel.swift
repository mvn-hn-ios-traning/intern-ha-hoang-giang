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
    
    private let navigator: ProfileNavigator
    
    init(navigator: ProfileNavigator) {
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        
        let tappedLoginOutput = input
            .tappedLogin
            .do(onNext: navigator.toLoginScreen)
        
        return Output(tappedLoginOutput: tappedLoginOutput)
    }
    
}

extension ProfileViewModel {
    struct Input {
        let tappedLogin: Driver<Void>
    }
    
    struct Output {
        let tappedLoginOutput: Driver<Void>
    }
}
