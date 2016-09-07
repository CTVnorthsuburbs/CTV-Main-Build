//
//  VideoSearch.swift
//  HalfTunes
//
//  Created by William Ogura on 8/17/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation
import UIKit

/// VideoSearch Class handles the URL session, searches sent to api, handling of the results, and splitting of result arrays that are sent back to the api in order to get the shows

class VideoSearch : UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
private var searchResults = [Video]()

// This determines the size of the split arrays and effects when the initial result array is split by setting a limit as to when the split occurs, and the returned page size from CableCast
    
let arrayLength = 50

/// Creates the NSURL session necessary to download content from remote URL
    
private func getNSURLSession() -> NSURLSession {
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    
    return defaultSession
    
}

/**
 Search returns results from saved search stored in cablecast frontdoor. The function calls the getNSURLSession, accessing the searchURL, receives the results from the API as IDs, it then parses the results array into smaller slices defined by the arrayLength Int value, and then creates new urls from these slices, that are sent to the API in order to receive the necessary Shows
- parameter savedSearchID: Int value equal to the stored search ID determined by the CableCast Frontdoor
*/
    
private func search(savedSearchID: Int)-> [Video] {
    
    searchResults.removeAll()
        
    let session = getNSURLSession()
        
    let searchUrl = NSURL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/search/advanced/savedshowsearch/?id=\(savedSearchID)")
        
    let results = getSearchResults(session, url: searchUrl!, isIDSearchURL: false)
    
    if (results!.count > arrayLength) {  // if array is longer than maximum, split it and process results, should be moved into separate split function so that the results are passed no matter the size and the function handles the rest
    
    let splitResults = splitIdArray(results!)

    if (splitResults != nil) {
        
        var searchURLs = [NSURL]()
        
        var counter = 0
        
        for splitArray in splitResults! {

            let searchURL = convertIdArrayToSearchURL(splitArray)
          
            searchURLs.append(searchURL!)
            
            counter = counter + 1
            
        }
        
        for url in searchURLs {
      
             getSearchResults(session, url: url, isIDSearchURL: true)
            
        }
        
    } else {        //if array is smaller than maximum, just process it
        
   let searchIdURL =  convertIdArrayToSearchURL(results!)
        
   getSearchResults(session, url: searchIdURL!, isIDSearchURL: true)
        
        }
        
    }
    
    return searchResults
}

/**
Search by string returns an array of video objects corresponding to the search string passed
- parameter searchString: Search Keyword
*/
    
private func search(searchString: String)-> [Video] {
    
    searchResults.removeAll()
        
    let session = getNSURLSession()
        
    let searchURL = NSURL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/?search=\(searchString)&include=vod,thumbnail")
        
    getSearchResults(session, url: searchURL!, isIDSearchURL: true)
        
    return searchResults
}
    
private func splitIdArray(idArray: [Int])-> [[Int]]? {        //splits id array into sets of 50 in order to shorten search url. Maxium url length is 200 ids.
    
    var resultArray = [[Int]]()
    
    let arrayCount = idArray.count
    
    let numberOfArrays = arrayCount / arrayLength
    
    for _ in 0...numberOfArrays {
        
        resultArray.append([])
        
    }
    
    let count = numberOfArrays
    
    var position = -1
    
    for index in 0...count {
        
        var tempArray : [Int]
    
        if  (idArray.indices.contains(position + arrayLength) ){
            
             tempArray = Array(idArray[(position + 1 )...position + arrayLength])
            
        } else {
        // if there is less than arrayLength indexes left in array, calculate remainder and assign
         
        var range = idArray.count
            
        range = range % arrayLength
        
    
            
            tempArray = Array(idArray[position + 1...position + range])
        }
        
        
        for id in tempArray {
            
               resultArray[index].append(id)
            
        }
        
        position = position + arrayLength
        
    }
    
    var totalCount = 0
    
    for i in resultArray {
        
                  totalCount = totalCount + i.count
        
    }
    
//This bit below compares the results of the split with the orignal input array and prints an error if comparision fails
    
    var testArray = [Int]()
    
    for array in resultArray {
        

        for index in array {
            
                    testArray.append(index)
            
        }
        
    }
    
    var testResult = true
    
    var countPosition = 0
    
    for element in idArray {
        
        
        if (element != testArray[countPosition]) {
            
          testResult = false
            
        print(element)
            
        }
        
        countPosition = countPosition + 1
        
    }
    
    if(testResult == false) {
        
        print("split array does not match original id array")
        
        return nil
        
    }
    
   return resultArray
   
}
    
func getRecent() -> [Video] {
        
    search(52966)
        
    return searchResults
        
}
    
func getSport(sport: String)->[Video]{
        
    search(sport)
        
    return searchResults
        
}


private func getSearchResults(defaultSession: NSURLSession, url: NSURL, isIDSearchURL: Bool) -> [Int]? {
    
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


private func convertIdArrayToSearchURL(idArray: [Int]) -> NSURL? {
    
    var url = "http://trms.ctv15.org/Cablecastapi/v1/shows/?"
    
    var count = arrayLength //set a limit to results by matching split array length var
    
    for id in idArray {
        
        count = count - 1
        
        if (count >= 0) {
        
        url = url + "ids=\(id)&"
            
        }
        
    }
    
    url += "include=vod,thumbnail&page_size=\(arrayLength)"
    
    let searchURL = NSURL(string: url)
    
    return searchURL
    
}
    
private func getSavedSearchResults(data: NSData?) -> [Int]? {
        
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
    
    
private func updateSearchResults(data: NSData?)-> Bool {
        
    //searchResults.removeAll()
        
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