//
//  VideoSearch.swift
//  HalfTunes
//
//  Created by William Ogura on 8/17/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation
import UIKit

/** The VideoSearch Class handles the URL session, searches sent to the CableCast API, handling of the results, and splitting of result arrays that are sent back to the API in order to get the video objects. The class functions by first creating a NSURLSession to handle the JSON download. Next, a searchURL is created. This URL is accessed and the results are stored in the results Array. These results consist of an Int Array containing the ID's of the videos returned from the search. The ID Array must then be sent back to the API in order to receive the JSON Video objects that contain both a title and a video source URL. If the result Array containing the IDs is longer than the maxium limit, then it is split into smaller Arrays using the splitIdArray function. This function accepts the Int Array and returns an Array of Int Arrays. The size of each split Array is determined by the arrayLength variable. Once the Array is split, separate URLs are created for each split Array and these URLs are accessed in order to receive the JSON Video Objects that are appended to a single results array.
 
    Steps when recent Videos are requested:
    - getRecent() is called by an outside class.
    - search(52966) is called by getRecent(). The Int value passed is the Saved Search ID supplied by the CableCast Frontdoor.
    - search(savedSearchID: Int) removes the previous searchResults. Creates a new NSURL session and uses this session to access the searchURL.
    - The getSearchResults() returns the Array of Video IDs.
    - If the results array exceeds the maximum defined by the arrayLength property, then the results are passed to splitIdArray().
    - splitIdArray() returns the Array of Int Arrays. The Int Arrays are converted to Search URLs through convertIdArrayToSearchURL().
    - Each searchURL returned from convertIdArrayToSearchURL() are passed to getSearchResults() in order to receive the JSON Video Objects.
    - Finally the results are appended to the searchResults Video Array and this is returned to the orignal calling function getRecent().
*/



enum Category: Int {
    
    case recent = 52966
    
    case baseball = 67200
   // case baseball = 65794
    case hockey = 65797
    
    case basketball = 67204
    
    case nsb = 66603
    
    case concerts = 67318
    
    
    
    
    
}




class VideoSearch : UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
fileprivate var searchResults = [Video]()
    
    fileprivate var thumbnailResults = [Thumbnail]()
    
    


// This determines the size of the split arrays and effects when the initial result array is split by setting a limit as to when the split occurs, and the returned page size from CableCast.
    
let arrayLength = 55

/// Creates the NSURL session necessary to download content from remote URL.
    
fileprivate func getNSURLSession() -> URLSession {
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    
    return defaultSession
    
}

/**
 Search returns results from saved search stored in cablecast frontdoor. The function calls the getNSURLSession, accessing the searchURL, receives the results from the API as IDs, it then parses the results array into smaller slices defined by the arrayLength Int value, and then creates new urls from these slices, that are sent to the API in order to receive the necessary Shows
- parameter savedSearchID: Int value equal to the stored search ID determined by the CableCast Frontdoor.
*/
    
 func search(_ savedSearchID: Int)-> [Video] {
    
    searchResults.removeAll()
    
        
    let session = getNSURLSession()
        
    let searchUrl = URL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/search/advanced/savedshowsearch/?id=\(savedSearchID)")
    
    let results = getSearchResults(session, url: searchUrl!, isIDSearchURL: false)
    
    if (results!.count > arrayLength) {  // if array is longer than maximum, split it and process results, should be moved into separate split function so that the results are passed no matter the size and the function handles the rest.
    
    let splitResults = splitIdArray(results!)
        
    

    if (splitResults != nil) {
        
        
        
        var searchURLs = [URL]()
        
        var counter = 0
        
        
       
        for splitArray in splitResults! {

            let searchURL = convertIdArrayToSearchURL(splitArray)
            
          
          
            searchURLs.append(searchURL!)
            
            counter = counter + 1
            
        }
        
        for url in searchURLs {
      
             getSearchResults(session, url: url, isIDSearchURL: true)
            
        }
        
        } }
    
    
    else {        //if array is smaller than maximum, just process it
        
   let searchIdURL =  convertIdArrayToSearchURL(results!)
        
        
   getSearchResults(session, url: searchIdURL!, isIDSearchURL: true)
        
        }
        
    
    
    return searchResults
}


    func trimVideos(videoArray: [Video], numberToReturn: Int) -> [Video] {
        
       
        var reducedResults = [Video]()
        
        var count = numberToReturn
        
        for result in videoArray {
            
            
            if (count > 0) {
                reducedResults.append(result)
            }
            
            count = count - 1
            
            
        }
     
        return reducedResults
   
    }
    
    
    
/**
Search by string returns an array of video objects corresponding to the search string passed
- parameter searchString: Search Keyword
*/
    
fileprivate func search(_ searchString: String)-> [Video] {
    
    searchResults.removeAll()
        
    let session = getNSURLSession()
        
    let searchURL = URL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/?search=\(searchString)&include=vod,thumbnail")
        
    getSearchResults(session, url: searchURL!, isIDSearchURL: true)
        
    return searchResults
}
    
/** splitIdArray accepts an Int Array and splits the array into smaller Arrays, the size of which are defined by the arrayLength var. The return is an Array of Int Arrays.
- parameter idArray: Array of IDs supplied by getSearchResults()
*/
    
    
fileprivate func splitIdArray(_ idArray: [Int])-> [[Int]]? {
    
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
        // if there is less than arrayLength indexes left in array, calculate remainder and assign.
         
        var range = idArray.count
            
        range = range % arrayLength
        
    
            
          //  tempArray = Array(idArray[position...position + range])
            
            
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
    
//This bit below compares the results of the split with the orignal input array and prints an error if comparision fails.
    
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

/// getRecent() returns the most recent Videos from CableCast as defined by the Saved Search 'App Basic Search'.
    
func getRecent() -> [Video] {
        
    search(52966)
       
    return searchResults
        
}
    
    
    func getRecentLimited() -> [Video] {
        
        search(52966)
        
        
        var count = 10
        
        var reducedResults = [Video]()
        
       
        
        for result in searchResults {
            
            
            if (count > 0) {
            reducedResults.append(result)
            }
            
            count = count - 1
            
            
        }
        
        
        
        
        return reducedResults
        
    }
    
    
    func getHockeyLimited() -> [Video] {
        
       search(65797)
        
      
        
        return searchResults
        
    }
    
    
    
    
    func getBasketball() -> [Video] {
        
        search(66589)
        
        
        
        return searchResults
        
    }
    
    

    
    
    func getNSB() -> [Video] {
        
        search(66603)
        
        
        
        return searchResults
        
    }
    


/// getSport() accepts a String Keyword that is passed as a search parameter.
    
func getSport(_ sport: String)->[Video]{
        
    search(sport)
        
    return searchResults
        
}


fileprivate func getSearchResults(_ defaultSession: URLSession, url: URL, isIDSearchURL: Bool) -> [Int]? {
    
    var dataTask: URLSessionDataTask?
    
    var results : [Int]?
    
    if dataTask != nil {
        
        dataTask?.cancel()
        
    }
    
    var complete = false
    
    dataTask = defaultSession.dataTask(with: url, completionHandler: {
        
        data, response, error in
        
        DispatchQueue.main.async {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
        }

        if let error = error {
            
            print(error.localizedDescription)
            
        } else if let httpResponse = response as? HTTPURLResponse {
            
            if httpResponse.statusCode == 200 {
                
                if (isIDSearchURL == true) {
                    
                   complete = self.updateSearchResults(data)
                
                    
                } else {
                    
                    results = self.getSavedSearchResults(data)!
                    
                }
                
            }
            
        }
        
    }) 
    
    dataTask?.resume()
    
    while (results == nil && complete == false) {
        
        //wait till results are received
    }
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    return results
    
}
    
    
    fileprivate func searchThumbnail(_ savedSearchID: Int)-> String?{
        
        thumbnailResults.removeAll()
        
        let session = getNSURLSession()
        
        let searchUrl = URL(string: "http://trms.ctv15.org/Cablecastapi/v1/thumbnails/\(savedSearchID)")
        
        // print("search url : \(searchUrl)")
        
        let results = getThumbnailResults(session, url: searchUrl!)
        
        return results
        
        
    }
    

    
    
    
    fileprivate func getThumbnailResults(_ defaultSession: URLSession, url: URL) -> String? {
        
        var dataTask: URLSessionDataTask?
        
        var thumbnail : String?
        
        if dataTask != nil {
            
            dataTask?.cancel()
            
        }
        
       
        
        dataTask = defaultSession.dataTask(with: url, completionHandler: {
            
            data, response, error in
            
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            }
            
            if let error = error {
                
                print(error.localizedDescription)
                
            } else if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
               
                        
                    var json: [String: AnyObject]!
                    
                    
                    do {
                        
                        json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
                        
                        
                        
                    } catch {
                        
                        print(error)
                        
                    }
                    
                    
                    
                    guard let results = Thumbnail(json: json) else {
                       
                        return 
                    }
                    
                    guard let result = results.thumbnail else {
                        
                        return
                    }

                  
                   thumbnail = result.url
                    
                   
                    
                    
                }
                
            }
            
        }) 
        
    
        
        
        dataTask?.resume()
        
        
        while (thumbnail == nil ) {
            
            //wait till results are received
        }
        
        
              UIApplication.shared.isNetworkActivityIndicatorVisible = false
        return thumbnail
        
    }

fileprivate func convertIdArrayToSearchURL(_ idArray: [Int]) -> URL? {
    
    var url = "http://trms.ctv15.org/Cablecastapi/v1/shows/?"
    
    var count = arrayLength //set a limit to results by matching split array length var
    
    for id in idArray {
        
        count = count - 1
        
        if (count >= 0) {
        
        url = url + "ids=\(id)&"
            
        }
        
    }
    
    url += "include=vod,thumbnail&page_size=\(arrayLength)"
    
    let searchURL = URL(string: url)
    
    return searchURL
    
}
    
fileprivate func getSavedSearchResults(_ data: Data?) -> [Int]? {
        
    searchResults.removeAll()
        
    var json: [String: AnyObject]!
        
        
    do {
            
        json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
        
    
            
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

    
    
  public  func getThumbnail(id: Int)-> UIImage? {

        var image : UIImage?
        

        var thumbnailURL = searchThumbnail(id)
        
        
        if(thumbnailURL != nil ) {
            
            
                 let escapedString = thumbnailURL!.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            
            
            
            let url = NSURL(string: escapedString! )
       
            if(url != nil) {
                let data = NSData(contentsOf: url! as URL) //make sure your image in this url does exist, otherwise unwrap in a if let check
                image = UIImage(data: data! as Data)
                
            
                var imageView = UIImageView()
                imageView.image = image
           
                
                
                return(image)
            } 
            
        }
    
    return image
        
    }
    
    
    
    
    
fileprivate func updateSearchResults(_ data: Data?)-> Bool {
        
    //searchResults.removeAll()
        
    var json: [String: AnyObject]!
        
        
    do {
            
        json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
            
    } catch {
            
        print(error)
            
    }
    
    guard let VideosResult = VideosResult(json: json) else {
     
        return false
            
    }
        
    guard VideosResult.show != nil else {
        
  
        return false
            
    }
    

    
    
    

    
  
    var count = 0

 
    var fileName : Int?

    
    for show in VideosResult.show! {
        
   
        
        if(show.showThumbnail.count != 0) {
            
            fileName = show.showThumbnail[2]
            
        } else {
            
            fileName = nil
        
    
        }
        
   
        var date = convertStringToDate(dateString: show.date)
        
        if(VideosResult.show?.count != VideosResult.vod?.count) {
            
            print("video results do not match!!")
            
            
        }
        
        
        
        searchResults.append(Video(title: show.title, thumbnail: nil , fileName: fileName, sourceUrl: VideosResult.vod![count].url, comments : show.comments, eventDate:  date)!)
        

    
        
        count += 1


    }
    


    return true
        
    }

}
