//
//  ImageHandler.swift
//  HalfTunes
//
//  Created by William Ogura on 11/29/16.
//
//

import Foundation


import UIKit


var imageRadius: CGFloat = 2.0

var buttonRadius: CGFloat = 2.0


let imageCache = NSCache<AnyObject, AnyObject>()

var returnImage:UIImage = UIImage()

func returnImageUsingCacheWithURLString(url: NSURL) -> UIImage? {
    
    // First check if there is an image in the cache
    if let cachedImage = imageCache.object(forKey: url) as? UIImage {
      
        return cachedImage
    }
        
    else {
      
        
        // Cache to image so it doesn't need to be reloaded everytime the user scrolls and table cells are re-used.
        
        
        let data = NSData(contentsOf: url as URL )
        
        if (data == nil) {
            
            print("image not found")
            
            
            return nil
            
            
        } else {
            
            if let downloadedImage = UIImage(data: data as! Data ){
                
                imageCache.setObject(downloadedImage, forKey: url)
                
             
                returnImage = downloadedImage
                
                
                
                
            } else {
                
                
                print("image not found")
                
                
                return nil
            }
            
        }
    }
    
    
    return returnImage
    
}









