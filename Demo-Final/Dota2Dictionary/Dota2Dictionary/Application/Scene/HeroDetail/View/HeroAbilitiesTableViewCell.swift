//
//  HeroAbilitiesTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 05/11/2021.
//

import UIKit
import Kingfisher

class HeroAbilitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var abilityImage: UIImageView!
    @IBOutlet weak var abilityName: UILabel!
    @IBOutlet weak var abilityDescription: UILabel!
    
    @IBOutlet weak var manaCostLabel: UILabel!
    @IBOutlet weak var manaIcon: UIImageView!
    @IBOutlet weak var coldownLabel: UILabel!
    @IBOutlet weak var coldownIcon: UIImageView!
    
    @IBOutlet weak var behaviorLable: UILabel!
    @IBOutlet weak var dmgType: UILabel!
    @IBOutlet weak var bkbPierce: UILabel!
    @IBOutlet weak var attribute: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        abilityImage.layer.cornerRadius = abilityImage.frame.size.width / 2
    }

    func configure(_ viewModel: HeroDetailAbilitiesModel) {
        configureAvatar(viewModel)
        
        abilityName.text = viewModel.dname
        
        guard let descrip = viewModel.desc else {return}
        abilityDescription.text = descrip
        
        configureMCCD(viewModel)
        
        behaviorLable.text = "Behavior: " + (viewModel.behavior?.rawValue ?? "No behavior")
        
        dmgType.text = "Damage type: " + (viewModel.dmgType ?? "No damage")
        
        bkbPierce.text = "BKB Pierce: " + (viewModel.bkbPierce ?? "No")
        
        configureAttrib(viewModel)
    }
    
    func configureAvatar(_ viewModel: HeroDetailAbilitiesModel) {
        // download image from url with kingfisher
        let url = URL(string: ConstantsForImageURL.heroAbilityImage + viewModel.abilitiesKey + ".png")
        let processor = DownsamplingImageProcessor(size: abilityImage.bounds.size)
        KF.url(url)
          .placeholder(UIImage(named: "placeholderImage"))
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .onProgress { _, _ in  }
          .onSuccess { _ in  }
          .onFailure { _ in }
          .set(to: abilityImage)
    }
    
    func configureMCCD(_ viewModel: HeroDetailAbilitiesModel) {
        manaCostLabel.text = viewModel.manaCost?.mccdValue
        coldownLabel.text = viewModel.coldown?.mccdValue
        
        if viewModel.manaCost == nil {
            manaCostLabel.text = "0"
        }
        if viewModel.coldown == nil {
            coldownLabel.text = "0"
        }
    }
    
    func configureAttrib(_ viewModel: HeroDetailAbilitiesModel) {
        let abstractArray = viewModel.attrib?.filter { $0.generated == nil }
        
        var resultText: String = ""

        for each in abstractArray! {
            let eachResult = each.header + " " + each.value.mccdValue + "\n\n"
            resultText.append(eachResult)
        }
        attribute.text = resultText
        
    }
    
}
