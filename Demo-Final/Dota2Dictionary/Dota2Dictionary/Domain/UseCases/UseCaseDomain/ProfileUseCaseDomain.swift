//
//  ProfileUseCaseDomain.swift
//  Dota2Dictionary
//
//  Created by MacOS on 18/11/2021.
//

import Foundation
import RxSwift

public protocol ProfileUseCaseDomain {
    func signout()
    func login(email: String, password: String) -> Observable<String>
    func resetPassword(email: String) -> Observable<String>
}
