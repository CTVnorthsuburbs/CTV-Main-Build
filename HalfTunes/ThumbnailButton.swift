//
//  ThumbnailButton.swift
//  HalfTunes
//
//  Created by William Ogura on 11/1/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit




class ThumbnailButton {
    
    var thumbnail: UIImage
    
    var category: Category
    
    
    init(thumbnail: UIImage, category: Category) {
        
        
        self.thumbnail = thumbnail
        
        self.category = category
        
        
        
        
        
        
    }
    
    
    convenience init?(thumbnail: String, category: Category) {
        
        
        
        
        var image: UIImage
        
        let escapedString = thumbnail.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        
        
        let url = NSURL(string: escapedString! )
        
        if(url != nil) {
            let data = NSData(contentsOf: url! as URL) //make sure your image in this url does exist, otherwise unwrap in a if let check
            image = UIImage(data: data! as Data)!
            
            
            let imageView = UIImageView()
            
            imageView.image = image
            
            
            
            
            
          self.init(thumbnail: image, category: category)
       
        
        }
        
      return nil
        
    
    }

}
    
    

    
    
    
    




    
    
    
