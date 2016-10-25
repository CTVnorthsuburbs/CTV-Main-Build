//
//  SlideShow.swift
//  HalfTunes
//
//  Created by William Ogura on 10/25/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

import AVFoundation

class SlideShow: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var imageArray = [UIImage]()
  
    override func viewDidLayoutSubviews() {
        
        
       // super.viewDidLoad()
        
        mainScrollView.frame = view.frame
        
       
        
        imageArray = [#imageLiteral(resourceName: "mobile-saints"),#imageLiteral(resourceName: "mobile-grad-slide"),#imageLiteral(resourceName: "mobile-exterior"),#imageLiteral(resourceName: "mobile-roseparade")]
        
        for i in  0..<imageArray.count {
            
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode  = .scaleAspectFit
            
            let xPostion = self.view.frame.width * CGFloat(i)
           imageView.frame = CGRect(x: xPostion, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height )
            
            
           // imageView.frame = CGRect(x: xPostion ,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            
        //    imageView.frame = AVMakeRect(aspectRatio: (imageView.image?.size)!, insideRect: imageView.bounds)
            
            
          
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            
            mainScrollView.addSubview(imageView)
            
          
        }
        
        
        
        
        
    }
}
