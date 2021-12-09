//
//  ProfileInfoTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 23/11/2021.
//

import UIKit
import Firebase
import Kingfisher

class ProfileInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatar.image = nil
    }
    
    @IBAction func signOut(_ sender: Any) {
        sureToLogout()
    }
    
    func configure(_ model: String) {
        self.modelAvatar()
        Auth.auth().addStateDidChangeListener { (_, user) in
            guard let avatar = user?.photoURL,
                let name = user?.displayName,
                let email = user?.email
                else {
                    return
            }
            
            self.avatar.kf.setImage(with: avatar)
            self.nameUser.text = "Username: \(name)"
            self.emailUser.text = "Email: \(email)"
            
        }
    }
    
    func modelAvatar() {
        avatar.layer.borderWidth = 1.0
        avatar.layer.masksToBounds = true
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.cornerRadius = avatar.frame.size.width/2
        avatar.clipsToBounds = true
    }
    
    func sureToLogout() {
        let alert = UIAlertController(title: "Log out",
                                      message: "Are you sure to log out?",
                                      preferredStyle: .alert)
        let action1 = UIAlertAction(title: "No",
                                    style: .cancel,
                                    handler: nil)
        let action2 = UIAlertAction(title: "Yes",
                                    style: .destructive) { _ in
            do {
                try Auth.auth().signOut()
            } catch {
                print("error in signout")
            }
        }
        alert.addAction(action1)
        alert.addAction(action2)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
