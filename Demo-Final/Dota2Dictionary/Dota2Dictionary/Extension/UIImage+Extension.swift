//
//  UIImage+Extension.swift
//  Dota2Dictionary
//
//  Created by MacOS on 23/11/2021.
//

import UIKit

extension UIImage {
    /// Save PNG in the Documents directory
    func save(_ name: String) -> URL {
        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let url = URL(fileURLWithPath: path).appendingPathComponent(name)
        guard let image = self.pngData() else { return url }
        try? image.write(to: url)
        print("saved image at \(url)")
        return url
    }
}
