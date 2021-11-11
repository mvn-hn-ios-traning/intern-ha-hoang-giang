//
//  HeroRolesTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 19/10/2021.
//

import UIKit

class HeroRolesTableViewCell: UITableViewCell {

    @IBOutlet weak var roleID: UILabel!
    @IBOutlet weak var roleLevel: UILabel!
    
    func configure(_ viewModel: Roles) {
        roleID.text = String(viewModel.roleId)
        roleLevel.text = String(viewModel.level)
    }
    
}
