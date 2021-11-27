//
//  SelectObjectList.swift
//  ARapp
//
//  Created by Max Nechaev on 27.11.2021.
//

import Foundation
import UIKit

class SelectObjectList {
    static let objects: [ObjectModel] = [ObjectModel(objectName: "fender",
                                              objectImage: UIImage(named: "fender")),
                                  ObjectModel(objectName: "flower_tulip",
                                              objectImage: UIImage(named: "flower")),
                                  ObjectModel(objectName: "teapot",
                                              objectImage: UIImage(named: "teapot")),
                                  ObjectModel(objectName: "toy_car",
                                              objectImage: UIImage(named: "toyCar")),
                                  ObjectModel(objectName: "tv_retro",
                                              objectImage: UIImage(named: "retroTV")),
                                  ObjectModel(objectName: "wateringcan",
                                              objectImage: UIImage(named: "wateringCan"))
    ]
}
