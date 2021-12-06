//
//  ProfileSignOutTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 23/11/2021.
//

import UIKit
import Firebase

class ProfileSignOutTableViewCell: UITableViewCell {

    func configure(_ model: String) { }
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("error in signout")
        }
    }
}
