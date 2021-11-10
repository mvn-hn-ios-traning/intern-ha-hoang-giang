//
//  HeroLanguageTableViewCell.swift
//  Dota2Dictionary
//
//  Created by MacOS on 04/11/2021.
//

import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

class HeroLanguageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ viewModel: HeroDetailViewModelPlus) {
        hypeLabel.text = viewModel.language.hype.htmlToString
    }
}
