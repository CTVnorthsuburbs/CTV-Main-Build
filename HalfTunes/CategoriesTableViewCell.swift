//
//  CategoriesTableViewCell.swift
//  HalfTunes
//
//  Created by William Ogura on 11/8/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryTitle: UILabel!
    
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
