//
//  VideoCell.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit


protocol VideoCellDelegate {
    func pauseTapped(cell: VideoCell)
    func resumeTapped(cell: VideoCell)
    func cancelTapped(cell: VideoCell)
    func downloadTapped(cell: VideoCell)
}



class VideoCell: UITableViewCell {
    // MARK: Properties
    
 

    @IBOutlet weak var thumbnailView: UIImageView!

    @IBOutlet weak var fileNameLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
   // var delegate: VideoCellDelegate?
    
     var delegate:VideoCellDelegate! = nil
 
    
    
    
    
    
   
    
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!

    @IBOutlet weak var progressLabel: UILabel!

  

   
    
    @IBAction func pauseOrResumeTapped(sender: AnyObject) {
        if(pauseButton.titleLabel!.text == "Pause") {
            delegate?.pauseTapped(self)
        } else {
            delegate?.resumeTapped(self)
        }
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        delegate?.cancelTapped(self)
    }
    
    @IBAction func downloadTapped(sender: AnyObject) {
        
        
        if (delegate == nil) {
            
            
            print("equalis nil")
        }
        
                delegate!.downloadTapped(self)
    }
}
