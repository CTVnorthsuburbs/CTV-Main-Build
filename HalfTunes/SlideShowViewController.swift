//
//  SlideShow.swift
//  HalfTunes
//
//  Created by William Ogura on 10/25/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

import AVFoundation

class SlideShowViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var imageArray = [UIImage]()
    
     var timer : Timer?
    
    var timerDelay = 6.0
  
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var titleTextLabel: UILabel!
    
    
 
    
    
    
    
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
    

    func slideshowTick() {
        
        
        
    
        var page = Int(mainScrollView.contentOffset.x / mainScrollView.frame.size.width)
        
        page = page + 1
        
        if(page == 4) {
            
            
            page = 0
        }
        
        
       
        
        
        var nextPage = page
   
     
      
        
        
    
        
   //print(nextPage)
        
        
      //  self.mainScrollView.scrollRectToVisible(CGRect(x: self.mainScrollView.frame.width * CGFloat(nextPage), y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height ), animated:true)
        
        
        self.mainScrollView.setContentOffset(CGPoint(x: self.mainScrollView.frame.width * CGFloat(nextPage), y: 0), animated: true)
        
        
    
      
        
      //  scrollView.scrollRectToVisible(CGRect(x: x, y: y, width: 1, height: 1), animated: true)
        
        
      //  self.setCurrentPageForScrollViewPage(nextPage);
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
      timer?.invalidate()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: timerDelay, target: self, selector: "slideshowTick", userInfo: nil, repeats: true)

    }
    
    
    

    
    
}
