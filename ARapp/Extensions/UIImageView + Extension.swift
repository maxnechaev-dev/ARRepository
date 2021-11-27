//
//  UIImageView + Extension.swift
//  ARapp
//
//  Created by Max Nechaev on 27.11.2021.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
