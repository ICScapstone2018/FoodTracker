//
//  ExpiryIndicator.swift
//  FoodTracker
//
//  Created by  Kerensa E Mattison on 2018-02-08.
//  Copyright © 2018  Kerensa E Mattison. All rights reserved.
//

import UIKit

class ExpiryIndicator: UIStackView {
    private var indicators = [UIImageView]()
    private let indicatorCount: Int = 10
    var indicatorPercentage: Int = 100 {
        didSet {
            for i in 0..<indicatorCount {
                indicators[i].alpha = i * indicatorCount < indicatorPercentage ? 1.0 : 0.1
            }
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        for _ in 0..<self.indicatorCount {
            let indicator = UIImageView(image: #imageLiteral(resourceName:"defaultImage"))
            indicator.contentMode = .scaleToFill
            self.addArrangedSubview(indicator)
            indicators.append(indicator)
        }
    }
    
    func setIndicatorPercentage(date: Date) {
        let expiryMath: Double = (60*60*24*30) / 100
        let expiryTime = Int(date.timeIntervalSinceNow/expiryMath)
        self.indicatorPercentage = expiryTime
        //let monthDate = (60*60*24*30) / 100
        //return(date.timeIntervalSinceNow / Double(monthDate))
 }
    
   // func expiry(date: Date) {
     //   self.indicatorPercentage = Int(self.setIndicatorPercentage(date: date))
    //}
}
