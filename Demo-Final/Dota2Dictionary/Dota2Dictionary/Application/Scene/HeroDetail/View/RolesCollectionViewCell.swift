//
//  RolesCollectionViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 04/11/2021.
//

import UIKit

class RolesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roleName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(role: RolesDetail) {
        roleName.text = role.roleName
    }
    
}
