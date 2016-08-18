//
//  VideoSearch.swift
//  HalfTunes
//
//  Created by William Ogura on 8/17/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation
import UIKit


class VideoSearch : UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
var searchResults = [Video]()

func getNSURLSession() -> NSURLSession {
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    
    return defaultSession
    
}
    
private func search(savedSearchID: Int)-> [Video] {
        
    let session = getNSURLSession()
        
    let searchUrl = NSURL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/search/advanced/savedshowsearch/?id=\(savedSearchID)")
        
    let results = getSearchResults(session, url: searchUrl!, isIDSearchURL: false)
        
    let searchIdURL =  convertIdArrayToSearchURL(results!)
        
    getSearchResults(session, url: searchIdURL!, isIDSearchURL: true)
    
    return searchResults
}
    
private func search(searchString: String)-> [Video] {
        
    let session = getNSURLSession()
        
    let searchURL = NSURL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/?search=\(searchString)&page_size=200&include=vod,thumbnail")
        
    getSearchResults(session, url: searchURL!, isIDSearchURL: true)
        
    return searchResults
}
    
func getRecent() -> [Video] {
        
    search(52966)
        
    return searchResults
        
}
    
func getSport(sport: String)->[Video]{
        
    search(sport)
        
    return searchResults
        
}


func getSearchResults(defaultSession: NSURLSession, url: NSURL, isIDSearchURL: Bool) -> [Int]? {
    
    var dataTask: NSURLSessionDataTask?
    
    var results : [Int]?
    
    if dataTask != nil {
        
        dataTask?.cancel()
    }
    
    var complete = false
    
    dataTask = defaultSession.dataTaskWithURL(url) {
        
        data, response, error in
        
        dispatch_async(dispatch_get_main_queue()) {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
        }

        if let error = error {
            
            print(error.localizedDescription)
            
        } else if let httpResponse = response as? NSHTTPURLResponse {
            
            if httpResponse.statusCode == 200 {
                
                if (isIDSearchURL == true) {
                    
                   complete = self.updateSearchResults(data)
                    
                    if (complete) {
                        
                    }
                    
                    
                } else {
                    
                    results = self.getSavedSearchResults(data)!
                    
                }
                
            }
            
        }
        
    }
    
    dataTask?.resume()
    
    while (results == nil && complete == false) {
        
        //wait till results are received
    }
    
    return results
    
}


func convertIdArrayToSearchURL(idArray: [Int]) -> NSURL? {
    
    var url = "http://trms.ctv15.org/Cablecastapi/v1/shows/?"
    
    for id in idArray {
        
        url = url + "ids=\(id)&"
        
    }
    
    url += "page_size=200&include=vod,thumbnail"
    
    let searchURL = NSURL(string: url)
    
    return searchURL
    
}
    
func getSavedSearchResults(data: NSData?) -> [Int]? {
        
    searchResults.removeAll()
        
    var json: [String: AnyObject]!
        
        
    do {
            
        json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
            
    } catch {
            
        print(error)
            
    }
        
    guard let VideosResult = AllVideos(json: json) else {
            
        return nil
            
    }
        
    guard let results = VideosResult.results else {
            
        return nil
    }
        
    guard let result = results["results"] else {
            
        return nil
    }
        
    let finalResult = result as! [Int]
        
    return finalResult
        
}
    
    
func updateSearchResults(data: NSData?)-> Bool {
        
    searchResults.removeAll()
        
    var json: [String: AnyObject]!
        
        
    do {
            
        json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
            
    } catch {
            
        print(error)
            
    }
        
    guard let VideosResult = VideosResult(json: json) else {
            
        return false
            
    }
        
    guard VideosResult.show != nil else {
            
        return false
            
    }
        
    guard let vod = VideosResult.vod!.first else {
            
        return false
            
    }
    
    var count = 0
        
    for show in VideosResult.show! {
        
        searchResults.append(Video(title: show.title, thumbnail: nil, fileName: VideosResult.vod![count].fileName, sourceUrl: VideosResult.vod![count].url)!)
        
        count += 1


    }
        
    return true
        
    }

}