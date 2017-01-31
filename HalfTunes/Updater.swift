//
//  Updater.swift
//  CTV App
//
//  Created by William Ogura on 1/25/17.
//  Copyright © 2017 Ken Toh. All rights reserved.
//

import Foundation

import UIKit



class Updater {
    
    var slideShow = [Slide]()
    
    
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
    
    
    
      var url = URL(string: "http://www.ctv15.org/mobile_app/slider.json")
  

    
    
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
                
                
                
                //  self.getSearchResults(defaultSession, url: url, isIDSearchURL: isIDSearchURL)
                
                
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

    
    func checkCategory(string: String) -> CategoryFactorySettings {
        
        
        if(string == "volleyball") {
            
            return volleyballFactorySettings()
            
            
            
            
        }
        
        
        if(string == "basketball") {
            
            return basketballFactorySettings()
            
            
            
            
        }
        
        
        if(string == "swimming") {
            
            return swimmingFactorySettings()
            
            
            
            
        }
        
    return soccerFactorySettings()
        
        
        
    }
    
    
    
    
    func updateSlideShow(updateResults: SlideShow) {
        
        
        var images = [UIImage]()
        
        
        for slide in updateResults.slides! {
            
            
            
            
            var thumbnailURL = NSURL(string: "http://www.ctv15.org/mobile_app/\(slide.imageURL!)")
            
            
            var image = search.getThumbnail(url: thumbnailURL!)
            
            if(image == nil) {
                
                
                
                print("Image for slide unavailable")
                
            } else {
                
                images.append(image!)
                
                
                
                var slideCategory  = checkCategory(string: slide.category!)
                
                var slide = Slide(slideType: ButtonType.category, searchID: nil, videoList: nil, page: nil, category: slideCategory, image:image, title: slide.title, webURL: nil)
                
                
                slideShow.append(slide)
                
                
            }
            
            
        }
        
        
        
        self.slideSection = Section(sectionType: SectionType.slider, sectionTitle: "SlideShow", searchID: 000, videoList: nil, buttons: nil, displayCount: nil, images: images, sectionPlaylist: nil)
        
        
        for slide in slideShow {
            
            
            
            
            self.slideSection?.addSlide(slide: slide)
            
            
            
        }
        
        
        
        
    }

fileprivate func updateSearchResults(_ data: Data?)-> Bool {
    
    
    var json: [String: AnyObject]!
    
    
    do {
        
        json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
        
    } catch {
        
        print(error)
        
    }
    
    guard let updateResults = SlideShow(json: json) else {
        
        return false
        
    }
    
    
    updateSlideShow(updateResults: updateResults)
    
    
    


    /*
    for result in updateResults.slideShow {
        
        
        
        
        
        guard let slide = Slides(json: result as! JSON) else {
            
            
            print("no itmes")
            
            
            return false
        }
        
        
        
    }
*/
    
    
    /*
    
    guard let results = YoutubeVideo(json: json) else {
        
        return false
    }
    
    
    //  print(results)
    //  var thumbnail = result
    
    
    
    for result in results.items! {
        
        
        
        
        
        guard let snippet = YoutubeItems(json: result as! JSON) else {
            
            
            print("no itmes")
            
            
            return false
        }
        
        
        
    }
    
   
    */
    
 
    
    

    
    
    
    
    
    return true
    
}

}
