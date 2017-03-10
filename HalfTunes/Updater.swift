//
//  Updater.swift
//  CTV App
//
//  Created by William Ogura on 1/25/17.
//  
//

import Foundation

import UIKit



class Updater {
    
    var slideShow = [Slide]()
    
    let slideShowImageURL = "http://www.ctv15.org/mobile_app/examples/uploads/"
    
    var slideSection: Section?
    
    var search = VideoSearch()
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    // This determines the size of the split arrays and effects when the initial result array is split by setting a limit as to when the split occurs, and the returned page size from CableCast.
    
    /// Creates the NSURL session necessary to download content from remote URL.
    
    fileprivate func getNSURLSession() -> URLSession {
        
        //   let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        //  session.configuration.urlCache?.removeAllCachedResponses()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        return defaultSession
        
    }
    
    func getSlideShowUpdate() -> Section? {
        
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var dataTask: URLSessionDataTask
        
        let url = URL(string: "http://www.ctv15.org/mobile_app/textForm/formdata.txt")
        
        dataTask = defaultSession.dataTask(with: url!,  completionHandler: {
            
            data, response, error in
            
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
            }
            
            if let error = error {
                
                print(error.localizedDescription)
                
            } else if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    self.updateSearchResults(data)
                    
                } else {
                    
                    print("!!!!!!!!!!!!!!!!!!!")
                    
                }
                
            }
            
            semaphore.signal()
            
        })
        
        dataTask.resume()
        
        semaphore.wait(timeout: .distantFuture)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        return slideSection
        
    }
    

    
    func checkCategory(string: String) -> CategoryFactorySettings? {
        
        let factory = NSClassFromString(string) as? CategoryFactorySettings.Type
        
        let factory1 = factory?.init()
        
        if(factory1 != nil) {
            
            return factory1
        }
        
        
        
        return home()
        
    }
    
    func updateSlideShow(updateResults: [Slides]) {
        
        
        
        var images = [UIImage]()
        
        slideShow = [Slide]()
        
        
        
        for slide in updateResults {
            
            let thumbnailURL = NSURL(string: "\(slideShowImageURL)\(slide.imageURL!)")
            
            
            var webURL: URL?
            
            let page = getPage(slide: slide)
            
            let categoryType = getSlideType(slide: slide)
            
            let videoID = getVideoID(slide: slide)
            
            
            if(slide.webURL != nil) {
                
                webURL = URL(string: (slide.webURL)!)
                
            }
            var image: UIImage?
            if(thumbnailURL != nil) {
                
                image = search.getThumbnail(url: thumbnailURL!)
            }
            
            var slideCategory: CategoryFactorySettings?
            
            if(slide.category != nil) {
                slideCategory  = checkCategory(string: slide.category!)
                
                
                
            }
            
            
            
            
            if(image == nil) {
                
                print("Image for slide unavailable")
                
            } else {
                
                
                
                
                images.append(image!)
                
                let slide = Slide(slideType: categoryType, searchID: videoID, videoList: videoID, page: page, category: slideCategory, image:image, title: slide.title, webURL: webURL)
                
                slideShow.append(slide)
                
            }
            
            
            
        }
        
        self.slideSection = Section(sectionType: SectionType.slider, sectionTitle: "SlideShow", searchID: 000, videoList: nil, buttons: nil, displayCount: nil, images: images, sectionPlaylist: nil)
        
        for slide in slideShow {
            
            self.slideSection?.addSlide(slide: slide)
            
        }
        
    }
    
    fileprivate func getVideoID(slide: Slides?) -> Int? {
        
        return slide?.videoID
        
        
        
    }
    
    fileprivate func getPage(slide: Slides?) -> String? {
        
        
        return slide?.page
        
    }
    
    fileprivate func getSlideType(slide: Slides?) -> ButtonType {
        
        if(slide?.slideType == "webPage") {
            
            
            
            return ButtonType.webPage
            
            
            
        } else {
            
            
            if(slide?.slideType == "video") {
                
                
                
                return ButtonType.video
            }
            
            if(slide?.slideType == "page") {
                
                
                
                return ButtonType.page
            }
            
            if(slide?.slideType == "web") {
                
                
                return ButtonType.webPage
            }
            
            if(slide?.slideType == "liveEvent") {
                
                
                return ButtonType.liveEvent
            }
            
            
            return ButtonType.category
        }
        
        
    }
    
    fileprivate func updateSearchResults(_ data: Data?)-> Bool {
        
        
        
        var json: [[String: AnyObject]]!
        
        
        do {
            
            json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [[String: AnyObject]]
            
        } catch {
            
            print(error)
            
        }
        
        // print("HERE IS THE DOWNLOAD \(json)")
        
        var updateResults = [Slides]()
        
        for result in json {
            
            
            updateResults.append(Slides(json: result)!)
            
            
            
        }
        
    
        
        updateSlideShow(updateResults: updateResults)
        
        
        
        return true
        
    }
    
}

