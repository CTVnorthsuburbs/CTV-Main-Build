//
//  SlideShow.swift
//  HalfTunes
//
//  Created by William Ogura on 10/25/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

import AVFoundation

import Foundation

class SlideShowViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var imageArray = [UIImage]()
    
     var timer : Timer?
    
    var timerDelay = 6.0
    
    var slides: [Slide]?
  
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var titleTextLabel: UILabel!
    
    
    
    
 
    func setSlides(slides: [Slide]) {
        
        
        
        self.slides = slides
        
        
     
        
        
        
    }
    
    func setSlider(slider: Section) {
        
      
        var images = slider.images as! [UIImage]
        
        if(images.count > 0) {
            
         
            self.imageArray = images
        }
        
        
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
    
    override func viewDidLayoutSubviews() {
        
       // super.viewDidLoad()
        
        mainScrollView.frame = view.frame
  
        imageArray = [#imageLiteral(resourceName: "mobile-saints") ]
        
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
        
        var parent = self.parent as! MainTableViewController
        
        
        parent.vc = self
        
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapImage(_:)))
       mainScrollView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    
    public func didTapImage(_ sender: UITapGestureRecognizer) {
       
        
 
            var page = Int(mainScrollView.contentOffset.x / mainScrollView.frame.size.width)
        
        
        if(slides != nil) {
        for slide in slides! {
            
            
            if (imageArray[page] == slide.image) {
                
                
                
                
                print("Slide \(slide.title)")
                
                
                self.slideAction(slide: slide)
            }
            
            
            
        }
            
        }
        
       /* if (slides?[page] != nil) {
            
            
            
            print(slides?[page].title)
            
            
        }
 
 */
        
        
        
        
    }
    
    
    func slideAction(slide: Slide) {
        
        
        
        var slide = slide
        
        
        
        
        if(slide.slideType == ButtonType.category) {
            
            
         
          
            
            
            
            category = Category(categoryFactory: CategoryFactory(factorySettings: slide.category!))
            
         
            
            //  category = (button?.category)!
            
            
            
            
            //  previousCategory = category
            
            // featured = false
            
            
            
            
            //  let viewController = MainTableViewController(category: (button?.category)!)
            
            
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "mainTable2") as! MainTableViewController
            
            vc.setCategory(newCategory: (category))
            
            
         //   currentCategory = category
            
            // self.navigationController?.pushViewController(vc, animated:true)
            
            
            
            self.parent?.navigationController?.show(vc, sender: self)
            
            
            
         
            
        }
        
        
       
        if(slide.slideType == ButtonType.page) {
            
            
            
            
            
            
            
            
            
            
            var page = slide.page
            
            
            
            
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: page!)
            
            
            vc.title = slide.title
            
            
            self.parent?.navigationController?.pushViewController(vc, animated:true)
            
        }
        
        /*
        
        
        
        if(slide.slideType == ButtonType.page) {
            
            
            
         
            
            
            var search = VideoSearch()
            
            
           var video = search.getYouTubePlaylists()
            
            
            
            
            var defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            
            var dataTask = URLSessionDataTask()
            
            var downloadsSession: Foundation.URLSession = {
                
                let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
                
                let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
                
                return session
                
            }()
            
            
            if(slide.category != nil) {
                category = Category(categoryFactory: CategoryFactory(factorySettings: slide.category!))
            }
            
            
            
       
            
         
            
            
            
            
            
            let destination = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "detailView") as! VideoViewController
            
        
            
            
            
            
            
            
            suggestedSearch = category.sections[0]
            
            //let selectedVideo = videos[collectionView.tag][indexPath.row]
            
            
            var thumbnail = search.getThumbnail(url: (video?.first?.thumbnailUrl)!)
            
            video?.first?.thumbnail = thumbnail
            
            destination.video = video?.first
            
            
            
            destination.setDefaultSession(defaultSession: &defaultSession)
            
            destination.setDataTask(dataTask: &dataTask)
            
            
            destination.setDownloadsSession(downloadsSession: &downloadsSession)
            
            
        
            
            //   self.navigationController?.pushViewController(destination, animated:true)
            
            
            
        
            
            self.parent?.navigationController?.pushViewController(destination, animated:true)
          
 
 
 
 
 
            
        }
        
        
        */
        
        
        
        if(slide.slideType == ButtonType.webPage) {
            
            
            
            /*
             
             var webview = UIWebView();
             
             
             
             webview.frame = CGRect(x: 0,y: 0, width: (self.parent?.view.frame.size.width)!, height: (self.parent?.view.frame.size.height)!);
             
             var url = button?.webURL
             
             var request = NSURLRequest(url: url! )
             
             webview.scalesPageToFit=true
             
             webview.loadRequest(request as URLRequest)
             
             self.parent?.view.addSubview(webview)
             
             */
            
            
            
            
            
            
            
            
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "webView") as! WebViewController
            
            
            vc.setTitle(title: (slide.title)!)
            
            vc.setPage(url: (slide.webURL)!)
            
            
            
            
            self.navigationController?.pushViewController(vc, animated:true)
            
            
            
            
            /*
             
             category = (button?.category)!
             
             previousCategory = category
             
             featured = false
             
             let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "mainTable2") as! MainTableViewController
             
             
             self.navigationController?.pushViewController(vc, animated:true)
             
             
             */
            
        }
        
        
        
        
        
        
        
    
        
        if(slide.slideType == ButtonType.video) {
            
            
            
   
            
            var defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            
            var dataTask = URLSessionDataTask()
            
            var downloadsSession: Foundation.URLSession = {
                
                let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
                
                let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
                
                return session
                
            }()
            
            
            if(slide.category != nil) {
           category = Category(categoryFactory: CategoryFactory(factorySettings: slide.category!))
            } 
            
            
            
            
            var search = VideoSearch()
            
            var video  = search.searchForSingle((slide.videoList?.first)!)
            
            
            
            
            
            let destination = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "detailView") as! VideoViewController
            
            
            
            
            
            
            
            
            suggestedSearch = category.sections[0]
            
            //let selectedVideo = videos[collectionView.tag][indexPath.row]
            
            destination.video = video.first
            
            
            
            destination.setDefaultSession(defaultSession: &defaultSession)
            
            destination.setDataTask(dataTask: &dataTask)
            
            
            destination.setDownloadsSession(downloadsSession: &downloadsSession)
            
            
            
            
            //   self.navigationController?.pushViewController(destination, animated:true)
            
            
         self.parent?.navigationController?.pushViewController(destination, animated:true)
            
 
            
            
        }
        
      
        
        
        
        
        
    }

    

    func slideshowTick() {

        var page = Int(mainScrollView.contentOffset.x / mainScrollView.frame.size.width)
        
        page = page + 1
        
        if(page == imageArray.count) {
            
            
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
    
    func resetSlidePosition() {
        
        if(self.mainScrollView != nil) {
        
         self.mainScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        timer = Timer.scheduledTimer(timeInterval: timerDelay, target: self, selector: "slideshowTick", userInfo: nil, repeats: true)
        
        
    }
    

}



extension SlideShowViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
}

func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    
    if let downloadUrl = downloadTask.originalRequest?.url?.absoluteString,
        
        let download = GlobalVariables.sharedManager.activeDownloads[downloadUrl] {
        // 2
        
        download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        // 3
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: ByteCountFormatter.CountStyle.binary)
        // 4
        
        
        /*
         if let videoIndex = videoIndexForDownloadTask(downloadTask), let videoCell = tableView.cellForRow(at: IndexPath(row: videoIndex, section: 0)) as? VideoCell {
         
         DispatchQueue.main.async(execute: {
         
         
         
         videoCell.progressView.progress = download.progress
         
         var temp =  GlobalVariables.sharedManager.getDownload(downloadUrl: downloadUrl)
         
         temp?.progress = download.progress
         
         
         
         
         
         })
         
         }
         */
    }
    
}

