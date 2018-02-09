//
//  FoodItemTableViewCell.swift
//  FoodTracker
//
//  Created by  Kerensa E Mattison on 2018-02-08.
//  Copyright © 2018  Kerensa E Mattison. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var expiryIndicator: ExpiryIndicator!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
