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
        guard let baseStr = viewModel.heroDetail.baseStr,
            let strGain = viewModel.heroDetail.strGain,
            let agilityBase = viewModel.heroDetail.baseAgi,
            let agilityGain = viewModel.heroDetail.agiGain,
            let intelligenceBase = viewModel.heroDetail.baseInt,
            let intelligenceGain = viewModel.heroDetail.intGain
            else { return }
        
        strengthBaseGain.text = String(Int(baseStr)) + " + " + String(strGain)
        
        agiBaseGain.text = String(Int(agilityBase)) + " + " + String(agilityGain)
        
        intelligentBaseGain.text = String(Int(intelligenceBase)) + " + " + String(intelligenceGain)
    }
    
    func attackStat(_ viewModel: HeroDetailViewModelPlus) {
        guard let startingDamageMin = viewModel.heroDetail.baseAttackMin,
            let startingDamageMax = viewModel.heroDetail.baseAttackMax,
            let attackRate = viewModel.heroDetail.attackRate,
            let attackRange = viewModel.heroDetail.attackRange
            else { return }
        
        dmgLabel.text = String(Int(startingDamageMin)) + " - " + String(Int(startingDamageMax))
        
        timeLabel.text = String(Int(attackRate))
        
        rangeLabel.text = String(attackRange)
    }
    
    func defense(_ viewModel: HeroDetailViewModelPlus) {
        guard let startingArmor = viewModel.heroDetail.baseArmor,
            let startingMagicArmor = viewModel.heroDetail.baseMr
            else { return }
        
        armorLabel.text = String(Int(startingArmor))
        
        resisLabel.text = String(startingMagicArmor)
    }
    
    func mobility(_ viewModel: HeroDetailViewModelPlus) {
        guard let moveSpeed = viewModel.heroDetail.moveSpeed else { return }
        
        moveLabel.text = String(moveSpeed)
    }
    
}
