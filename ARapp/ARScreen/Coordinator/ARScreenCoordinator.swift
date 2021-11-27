//
//  ARScreenCoordinator.swift
//  ARapp
//
//  Created by Max Nechaev on 27.11.2021.
//

import Foundation
import UIKit

class ARScreenCoordinator {
    static func configure(objectName: String) -> UIViewController {
        let presenter = ARScreenPresenter()
        let view = ARScreenView(output: presenter, objectName: objectName)
        return view
    }
}
