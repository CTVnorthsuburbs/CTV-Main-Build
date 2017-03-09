//
//  SlideShow.swift
//  HalfTunes
//
//  Created by William Ogura on 10/25/16.
//
//

import UIKit

import AVFoundation

import Foundation

class SlideShowViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var imageArray = [UIImage]()
    
    var timer : Timer?
    
    var timerDelay = 6.0
    
    var slides: [Slide]?
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var titleTextLabel: UILabel!
    
    func setSlider(slider: Section) {
        
        imageArray = [UIImage]()
        
        self.slides = slider.slides
        
        let images = slider.images as! [UIImage]
        
        
        if(images.count > 0) {
            
            
            self.imageArray = images
        }
        
        
        
        for i in  0..<imageArray.count {
            
            let imageView = UIImageView()
            
            imageView.image = imageArray[i]
            
            imageView.contentMode  = .scaleAspectFit
            
            let xPostion = self.view.frame.width * CGFloat(i)
            
            imageView.frame = CGRect(x: xPostion, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height )
            
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            
            mainScrollView.addSubview(imageView)
            
        }
        
    }
    
    //used to reset slideshow movement timer when slideshow is manually scrolled
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: timerDelay, target: self, selector: #selector(SlideShowViewController.slideshowTick), userInfo: nil, repeats: true)
        
    }
    
    
    
    func showLoadingOverlay() {
        
        
        DispatchQueue.main.async( execute: {
            
            LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
            
        })
        
        
    }
    
    
    func dismissLoadingOverlay() {
        
        DispatchQueue.main.async( execute: {
            
            LoadingOverlay.shared.hideOverlayView()
            
        })
        
    }
    
    
    override func viewDidLoad() {
        
        imageArray = [#imageLiteral(resourceName: "slide-placeholder")]
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
        mainScrollView.frame = view.frame
        
        for i in  0..<imageArray.count {
            
            let imageView = UIImageView()
            
            imageView.image = imageArray[i]
            
            imageView.contentMode  = .scaleAspectFit
            
            let xPostion = self.view.frame.width * CGFloat(i)
            
            imageView.frame = CGRect(x: xPostion, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height )
            
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            
            mainScrollView.addSubview(imageView)
            
        }
        
        let parent = self.parent as! MainTableViewController
        
        parent.vc = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapImage(_:)))
        
        mainScrollView.addGestureRecognizer(gestureRecognizer)
        
        mainScrollView.delegate = self
        
    }
    
    
    public func didTapImage(_ sender: UITapGestureRecognizer) {
        
        let page = Int(mainScrollView.contentOffset.x / mainScrollView.frame.size.width)
        
        if(slides != nil) {
            
            for slide in slides! {
                
                if (imageArray[page] == slide.image) {
                    
                    self.slideAction(slide: slide)
                    
                }
                
            }
            
        }
        
    }
    
    
    func slideAction(slide: Slide) {
        
        if(slide.slideType == ButtonType.category) {
            
            if(slide.category?.categoryTitle != category.categoryTitle) {
                
                category = Category(categoryFactory: CategoryFactory(factorySettings: slide.category!))
                
                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "mainTable2") as! MainTableViewController
                
                vc.setCategory(newCategory: (category))
                
                vc.setSlider()
                
                self.parent?.navigationController?.show(vc, sender: self)
                
            }
            
            
        }
        
        
        
        if(slide.slideType == ButtonType.page) {
            
            let page = slide.page
            
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: page!)
            
            vc.title = slide.title
            
            self.parent?.navigationController?.pushViewController(vc, animated:true)
            
        }
        
        
        if(slide.slideType == ButtonType.webPage) {
            
            print("webpage slide selected")
            
            
            
            
            
            
            /*
             
             // This code opens the web page inside a webview within the app  it was removed because JWPLayer 6 is still used by the meetings system
             
             let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "webView") as! WebViewController
             
             
             vc.setTitle(title: (slide.title)!)
             
             vc.setPage(url: (slide.webURL)!)
             print(slide.webURL!)
             
             
             
             self.navigationController?.pushViewController(vc, animated:true)
             
             */
            
            
            //This opens the webpage in safari
            
            if let url =  slide.webURL {
                
                UIApplication.shared.openURL(url)
                
            }
            
            
        }
        
        
        
        if(slide.slideType == ButtonType.video || slide.slideType == ButtonType.liveEvent ) {
            
            LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                
                var defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
                
                var dataTask = URLSessionDataTask()
                
                var downloadsSession: Foundation.URLSession = {
                    
                    let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
                    
                    let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
                    
                    return session
                    
                }()
                
                var slideCategory : Category?
                
                if(slide.category != nil) {
                    
                    slideCategory = Category(categoryFactory: CategoryFactory(factorySettings: slide.category!))
                    
                }
                
         
                
                var video = [Video]()
                
                var liveVideo: Video?
                
                if(slide.slideType == ButtonType.liveEvent) {
                    
                    
                    liveVideo  = Video(title: slide.title!, thumbnail: slide.image, fileName: 1, sourceUrl:  slide.webURL?.absoluteString, comments: "", eventDate: Date(), thumbnailUrl: nil, id: slide.videoList, isEvent: false, endDate: nil)
                    
                    
                } else {
                    
                    video  = search.searchForSingle((slide.videoList)!)
                    
                }
                
                let destination = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "detailView") as! VideoViewController
                
                if(slideCategory != nil) {
                    
                    slideCategory?.createListing()
                    
                    suggestedSearch = slideCategory?.sections.first
                    
                } else {
                    
                    suggestedSearch = category.sections.first
                    
                }
                
                
                if(slide.slideType == ButtonType.liveEvent) {
                    
                    destination.video = liveVideo
                    
                } else {
                    
                    destination.video = video.first
                    
                    
                }
                
                
                
                destination.setDefaultSession(defaultSession: &defaultSession)
                
                destination.setDataTask(dataTask: &dataTask)
                
                destination.setDownloadsSession(downloadsSession: &downloadsSession)
                
                self.parent?.navigationController?.pushViewController(destination, animated:true)
                
                DispatchQueue.main.async( execute: {
                    
                    LoadingOverlay.shared.hideOverlayView()
                })
                
            }
            
        }
        
    }
    
    
    
    func slideshowTick() {
        
        var page = Int(mainScrollView.contentOffset.x / mainScrollView.frame.size.width)
        
        page = page + 1
        
        if(page == imageArray.count) {
            
            page = 0
        }
        
        let nextPage = page
        
        self.mainScrollView.setContentOffset(CGPoint(x: self.mainScrollView.frame.width * CGFloat(nextPage), y: 0), animated: true)
        
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
        
        timer = Timer.scheduledTimer(timeInterval: timerDelay, target: self, selector: #selector(SlideShowViewController.slideshowTick), userInfo: nil, repeats: true)
        
    }
    
}



extension SlideShowViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
}

func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    
    if let downloadUrl = downloadTask.originalRequest?.url?.absoluteString,
        
        let download = GlobalVariables.sharedManager.activeDownloads[downloadUrl] {
        
        download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        
    }
    
}





