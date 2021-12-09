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
        
        let enableLogin = Driver
            .combineLatest(input.enteredEmail,
                           input.enteredPassword) {
                            return !$0.isEmpty
                                && !$1.isEmpty
        }
        
        let tappedLoginOutput = input
            .tappedLogin
            .withLatestFrom(mergeText) { _, text in
                self.useCase.login(email: text.0,
                                   password: text.1) }
            .asObservable()
            .flatMap {$0}
            .asDriver(onErrorDriveWith: .empty())
        
        let loginSuccess = tappedLoginOutput.map { text -> Bool in
            return text == "Login successfully"
        }
        
        let tappedRegisterOutput = input
            .tappedRegister
            .do(onNext: {
                self.navigator.toRegister()
            })
        
        let resetPassword = input
            .forgotTrigger
            .asObservable()
            .flatMap { self.useCase.resetPassword(email: $0) }
        
        let loadingLikedHero = self.useCase.loadLikedHero()
        let cellData = loadingLikedHero
            .map {
                [ProfileTableViewSection](arrayLiteral:
                    .infoSection(items: [.profileInfoItem(info: "")]),
                    .likeSection(items: $0.map { .profileLikeItem(like: $0) })
                )
        }
        
        return Output(enableLogin: enableLogin,
                      tappedLoginOutput: tappedLoginOutput,
                      tappedRegisterOutput: tappedRegisterOutput,
                      resetPasswordOuput: resetPassword,
                      loginSuccess: loginSuccess,
                      cellItems: cellData)
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
        let enableLogin: Driver<Bool>
        let tappedLoginOutput: Driver<String>
        let tappedRegisterOutput: Driver<Void>
        let resetPasswordOuput: Observable<String>
        let loginSuccess: Driver<Bool>
        let cellItems: Observable<[ProfileTableViewSection]>
    }
}
