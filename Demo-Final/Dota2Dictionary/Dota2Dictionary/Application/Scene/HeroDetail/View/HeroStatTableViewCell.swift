//
//  HeroStatTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 04/11/2021.
//

import UIKit

class HeroStatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var strengthBaseGain: UILabel!
    @IBOutlet weak var agiBaseGain: UILabel!
    @IBOutlet weak var intelligentBaseGain: UILabel!
    
    @IBOutlet weak var dmgLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var resisLabel: UILabel!
    
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var visionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ viewModel: HeroDetailViewModelPlus) {
        statBaseGain(viewModel)
        attackStat(viewModel)
        defense(viewModel)
        mobility(viewModel)
    }
    
    func statBaseGain(_ viewModel: HeroDetailViewModelPlus) {
        strengthBaseGain.text = String(Int(viewModel.stat.strengthBase)) + " + " + String(viewModel.stat.strengthGain)
        
        agiBaseGain.text = String(Int(viewModel.stat.agilityBase)) + " + " + String(viewModel.stat.agilityGain)
        
        intelligentBaseGain.text =
            String(Int(viewModel.stat.intelligenceBase)) + " + " + String(viewModel.stat.intelligenceGain)
    }
    
    func attackStat(_ viewModel: HeroDetailViewModelPlus) {
        dmgLabel.text =
            String(Int(viewModel.stat.startingDamageMin)) + " - " + String(Int(viewModel.stat.startingDamageMax))
        
        timeLabel.text = String(Int(viewModel.stat.attackRate))
        
        rangeLabel.text = String(Int(viewModel.stat.attackRange))
    }
    
    func defense(_ viewModel: HeroDetailViewModelPlus) {
        armorLabel.text = String(Int(viewModel.stat.startingArmor))
        
        resisLabel.text = String(Int(viewModel.stat.startingMagicArmor))
    }
    
    func mobility(_ viewModel: HeroDetailViewModelPlus) {
        moveLabel.text = String(Int(viewModel.stat.moveSpeed))
        
        turnLabel.text = String(Int(viewModel.stat.moveTurnRate))
        
        visionLabel.text =
            String(Int(viewModel.stat.visionDaytimeRange)) + "/" + String(Int(viewModel.stat.visionNighttimeRange))
    }
    
}
