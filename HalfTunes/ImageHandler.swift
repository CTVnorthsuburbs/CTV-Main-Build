//
//  ImageHandler.swift
//  HalfTunes
//
//  Created by William Ogura on 11/29/16.
//  Updated by Charlie Rooney on June 20th 2018
// This returns an image from the cache, if it is not in the cache, it puts it in the Cache and still returns the picture.

import Foundation
import UIKit

var imageRadius: CGFloat = 2.0
var buttonRadius: CGFloat = 2.0
let imageCache = NSCache<AnyObject, AnyObject>()
var returnImage:UIImage = UIImage()

func returnImageUsingCacheWithURLString(url: NSURL) -> UIImage?
{
    // First check if there is an image in the cache
    if let cachedImage = imageCache.object(forKey: url) as? UIImage {return cachedImage}
    
    // If not, Cache the image so it doesn't need to be reloaded everytime the user scrolls and table cells are re-used.
    else
    {
        if let data = NSData(contentsOf: url as URL )
        {
            if let image = UIImage(data: data as Data)
            {
                imageCache.setObject(image, forKey: url)
                return image
            }
        }
    }
    print("image not found: ImageHandler.swift line 34 ")
    return nil
}









