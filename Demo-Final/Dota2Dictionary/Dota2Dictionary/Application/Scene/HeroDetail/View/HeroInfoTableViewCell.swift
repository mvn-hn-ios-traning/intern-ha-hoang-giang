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
        heroName.text = viewModel.localizedName
                
        // download image from url with kingfisher
        let url = URL(string: ConstantsForImageURL.heroDetailAvatarImage + "\(viewModel.shortName).png")
        let processor = DownsamplingImageProcessor(size: heroAvatar.bounds.size)
        KF.url(url)
          .placeholder(UIImage(named: "placeholderImage"))
          .setProcessor(processor)
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .onProgress { _, _ in  }
          .onSuccess { _ in  }
          .onFailure { _ in }
          .set(to: heroAvatar)
    }
}
