//
//  LoginUseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 17/11/2021.
//

import Foundation
import RxSwift

// MARK: - Login
public protocol LoginUseCaseDomain {
    func resetPassword(email: String) -> Observable<String>
}
