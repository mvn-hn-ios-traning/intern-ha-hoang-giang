//
//  AttributeCollectionViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 28/09/2021.
//

import UIKit

class AttributeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var attributeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(attribute: String) {
        self.attributeImage.image = UIImage(named: attribute)
    }
}
