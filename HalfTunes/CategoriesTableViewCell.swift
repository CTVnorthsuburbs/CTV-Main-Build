//
//  CategoriesTableViewCell.swift
//  HalfTunes
//
//  Created by William Ogura on 11/8/16.
//  
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryTitle: UILabel!

    @IBOutlet weak var thumbnailImage: UIImageView!

    var category: Category?
    
    func setCategory(category: Category) {

        self.category = category

    }
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }

}
