//
//  SelectObjectCoordinator.swift
//  ARapp
//
//  Created by Max Nechaev on 27.11.2021.
//

import Foundation
import UIKit

class SelectObjectCoordinator {
    static func configure() -> UIViewController {
        let presenter = SelectObjectPresenter()
        let view = SelectObjectView(output: presenter)
        return view
    }
}
