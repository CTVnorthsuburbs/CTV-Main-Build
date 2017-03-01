//
//  Helpers.swift
//  CTV App
//
//  Created by William Ogura on 3/1/17.
//  Copyright © 2017 Ken Toh. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    
    
    func cropBottomImage(image: UIImage) -> UIImage {
        let height = CGFloat(image.size.height / 2)
        
        let heightFromBottom = CGFloat(image.size.height / 3.07)
        let rect = CGRect(x: 0, y: image.size.height - height - heightFromBottom , width: image.size.width, height: height)
        return cropImage(image: image, toRect: rect)
    }
    
    
    
    
    /*
     func cropBottomImage(image: UIImage) -> UIImage {
     let height = CGFloat(image.size.height / 1.3)
     let rect = CGRect(x: 0, y: image.size.height - height - 150, width: image.size.width, height: height)
     return cropImage(image: image, toRect: rect)
     }
     */
    
    
    
    
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    
    
    
    
    
}
