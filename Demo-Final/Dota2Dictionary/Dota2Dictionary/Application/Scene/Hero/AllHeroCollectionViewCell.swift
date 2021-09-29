//
//  AllHeroCollectionViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 28/09/2021.
//

import UIKit
import Kingfisher

class AllHeroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var heroAvatar: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .black
    }
    
    func bind(_ viewModel: HeroItemViewModel) {
        self.heroName.text = viewModel.heroName
        let url = URL(string: "http://cdn.dota2.com/apps/dota2/images/heroes/\(viewModel.heroAvatar)_full.png")
        let processor = DownsamplingImageProcessor(size: heroAvatar.bounds.size)
        heroAvatar.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
}
