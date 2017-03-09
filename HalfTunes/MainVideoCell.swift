//
//  VideoCell.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  
//

import Foundation

import UIKit

protocol MainVideoCellDelegate {
    
    func thumbnailTapped(_ cell: MainVideoCell)
    
}

class MainVideoCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var thumbnailView: UIImageView!
    

    @IBOutlet weak var thumbnailButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    // var delegate: VideoCellDelegate?
    
    var delegate:MainVideoCellDelegate! = nil
    
    @IBAction func thumbnailTapped(_ sender: AnyObject) {
        
        delegate?.thumbnailTapped(self)
        
    }

}
