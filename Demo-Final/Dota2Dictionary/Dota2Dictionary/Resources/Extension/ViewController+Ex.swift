//
//  ViewController+Ex.swift
//  Dota2Dictionary
//
//  Created by MacOS on 07/12/2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Around tapped
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
