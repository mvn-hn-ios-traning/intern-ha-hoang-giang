//
//  ComponentCollectionViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 18/10/2021.
//

import UIKit
import Kingfisher

class ComponentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var componentImage: UIImageView!
    @IBOutlet weak var componentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ component: String) {
        
        let url = URL(string:
                        "\(Constants.urlForImageItemVC)\(component).png")
        let processor = DownsamplingImageProcessor(size: componentImage.bounds.size)
        componentImage
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
        
        componentName.text = component.replacingOccurrences(of: "_", with: " ").capitalized
    }
    
}
