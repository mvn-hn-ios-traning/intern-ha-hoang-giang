//
//  HeroInfoTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 18/10/2021.
//

import UIKit
import RxSwift
import Kingfisher

class HeroInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroAvatar: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    
    private let disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        heroAvatar.image = nil
    }
    
    func configure(_ viewModel: HeroDetailViewModelPlus) {
        heroName.text = viewModel.displayName
        
        let url = URL(string: ConstantsForImageURL.heroDetailAvatarImage + "\(viewModel.shortName).png")

        let processor = DownsamplingImageProcessor(size: heroAvatar.bounds.size)
        heroAvatar
            .kf
            .setImage(
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
