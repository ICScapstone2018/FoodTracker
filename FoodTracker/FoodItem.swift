//
//  FoodItem.swift
//  FoodTracker
//
//  Created by  Kerensa E Mattison on 2018-02-08.
//  Copyright © 2018  Kerensa E Mattison. All rights reserved.
//

import Foundation
import UIKit
class FoodItem: NSObject {
    var image: UIImage
    var expiryDate: Date
    
    override convenience init() {
        self.init(image: #imageLiteral(resourceName: "defaultImage"), expiryDate: Date())
    }
    init(image: UIImage, expiryDate: Date) {
        self.image = image
        self.expiryDate = expiryDate
    }
}
