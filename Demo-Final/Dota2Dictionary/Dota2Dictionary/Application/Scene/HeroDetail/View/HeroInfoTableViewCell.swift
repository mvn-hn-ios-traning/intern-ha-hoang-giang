//
//  HeroInfoTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 18/10/2021.
//

import UIKit
import RxSwift

class HeroInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroName: UILabel!
    
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: HeroDetailViewModelPlus) {
        heroName.text = viewModel.displayName
    }
    
}
