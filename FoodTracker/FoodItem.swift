//
//  FoodItem.swift
//  FoodTracker
//
//  Created by  Kerensa E Mattison on 2018-02-08.
//  Copyright © 2018  Kerensa E Mattison. All rights reserved.
//
import os
import Foundation
import UIKit

class FoodItem: NSObject, NSCoding {
    
    class PropertyKey {
        static let image = "image"
        static let expiryDate = "expiryDate"
    }
    
    var image: UIImage
    var expiryDate: Date
    
    override convenience init() {
        self.init(image: #imageLiteral(resourceName: "defaultImage"), expiryDate: Date())
    }
    init(image: UIImage, expiryDate: Date) {
        self.image = image
        self.expiryDate = expiryDate
    }
        
static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
static let archiveURL = documentsDirectory.appendingPathComponent("foodItems")

required convenience init?(coder aDecoder: NSCoder) {
    guard let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage else {
        os_log("Missing image", log: OSLog.default, type: .debug)
        return nil
    }
    guard let date = aDecoder.decodeObject(forKey: PropertyKey.expiryDate) as? Date else {
        os_log("Missing date", log: OSLog.default, type: .debug)
        return nil
    }
    self.init(image: image, expiryDate: date)
}
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(expiryDate, forKey: PropertyKey.expiryDate)        
    }
}


