//
//  ItemDetailViewController.swift
//  Dota2Dictionary
//
//  Created by MacOS on 10/10/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var itemAvatar: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var costValue: UILabel!
    
    var itemDetailViewModel: ItemDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
