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



enum CategorySearches: Int {
    
    case recent = 52966
    
    case baseball = 67200
    // case baseball = 65794
    case hockey = 65794
    
    case basketball = 67204
    
    case nsb = 66603
    
    case concerts = 67318
    
    
    
}



enum button {
    
    case category
    
    case show
    
    case event
    
    case about
    
    case schedule
    
    case hockey
    
    case baseball
    
    case basketball
    
    case gymnastics
    
    case swimming
    
    case soccer
    
    case lacrosse
    
    case volleyball
    
    case football
    
}

enum Listing {
    
    case category
    
    case show
    
    case event
    
    case about
    
    case schedule
    
    case hockey
    
    case baseball
    
    case basketball
    
    case gymnastics
    
    case swimming
    
    case soccer
    
    case lacrosse
    
    case volleyball
    
    case football
    
}


protocol CategoryFactory {
    
    
    
    func addSlide() -> Section
    
    
    
    func addRecentSection() -> Section
    func addFeaturedSection() -> Section
    
    func addRecentBoysSection() -> Section
    
    func addRecentGirlsSection() -> Section
    
    func addPopularSection() -> Section
    
    func addButtons() -> Section
    
    
}

class hockeyFactory: CategoryFactory {
    
    
    /*
     
     class Section {
     
     var sectionType: SectionType
     
     var sectionTitle: String?
     
     var searchID: Int?
     
     var videoList: [Int]?
     
     var buttons: [button]?
     
     init(sectionType: SectionType) {
     
     self.sectionType = sectionType
     
     }
     
     }
     
     
     */
    
    
    
    
    internal func addPopularSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = "Popular Hockey Videos"
        
        let searchID = 68483
        
        let videoList: [Int]? = nil
        
        let buttons: [ThumbnailButton]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons)
        
        return section
    }
    
    internal func addRecentGirlsSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = "Girls Hockey Games"
        
        let searchID = 68489
        
        let videoList: [Int]? = nil
        
        let buttons: [ThumbnailButton]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons)
        
        return section
        
        
    }
    
    internal func addRecentBoysSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = "Boys Hockey Games"
        
        let searchID = 68492
        
        let videoList: [Int]? = nil
        
        let buttons: [ThumbnailButton]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons)
        
        return section
        
    }
    
    internal func addFeaturedSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = "Featured Hockey Videos"
        
        let searchID = 65794
        
        let videoList: [Int]? = nil
        
        let buttons: [ThumbnailButton]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons)
        
        return section
        
    }
    
    internal func addRecentSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = "Recent Hockey Videos"
        
        let searchID = 65794
        
        let videoList: [Int]? = nil
        
        let buttons: [ThumbnailButton]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons)
        
        return section
        
    }
    
    internal func addButtons() -> Section {
        
        let sectionType = SectionType.buttonNoTitle
        
        let sectionTitle: String? = nil
        
        let searchID: Int?  = nil
        
        let videoList: [Int]? = nil
        
        
        
        
        
        var thumbnailButtons = [ThumbnailButton]()
        
        thumbnailButtons.append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "categories"), category: CategorySearches.hockey))
        
        
        
        thumbnailButtons.append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "schedule"), category: CategorySearches.hockey))
        
        
        thumbnailButtons.append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "shows"), category: CategorySearches.hockey))
        
        thumbnailButtons.append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "events"), category: CategorySearches.hockey))
        
        
        
        
        
        
        
        /*
         thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "basketball"), category: CategorySearches.hockey))
         
         
         thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "volleyball"), category: CategorySearches.hockey))
         
         
         thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "hockey"), category: CategorySearches.hockey))
         
         
         thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "swimming"), category: CategorySearches.hockey))
         
         thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "football"), category: CategorySearches.hockey))
         
         thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "gymnastics"), category: CategorySearches.hockey))
         
         thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "baseball"), category: CategorySearches.hockey))
         
         
         */
        
        
        let buttons = thumbnailButtons
        
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons)
        
        return section
        
    }
    
    
    
    internal func addSlide() -> Section {
        
        let sectionType = SectionType.slider
        
        let sectionTitle = "Slider listing"
        
        let searchID = 68489
        
        let videoList: [Int]? = nil
        
        let buttons: [ThumbnailButton]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons)
        
        return section
        
    }
    
}


class Category: CategoryListing {
    
    
    var categoryFactory: CategoryFactory
    
    
    
    var sections = [Section]()
    
    var listing: CategorySearches
    
    
    required init() {
        
        categoryFactory = hockeyFactory()
        
        listing = CategorySearches.hockey
        
        
        
        
    }
    
    
    func createListing() {
        
        
        
        createFeaturedSection()
        
        
        createButtonSection()
        
        createPopularSection()
        
        createButtonSection()
        
        createRecentBoysSection()
        
        createRecentGirlsSection()
        
        
        
        
        
        
        
    }
    
    func createFeaturedSection() {
        
        sections.append(categoryFactory.addFeaturedSection())
        
        
        
    }
    
    func createSlider() {
        
        sections.append(categoryFactory.addSlide())
        
        
        
    }
    
    func createRecentSection() {
        
        sections.append(categoryFactory.addRecentSection())
        
        
        
        
    }
    
    func createRecentBoysSection() {
        
        sections.append(categoryFactory.addRecentBoysSection())
        
        
        
    }
    
    func createRecentGirlsSection() {
        
        sections.append(categoryFactory.addRecentGirlsSection())
        
        
        
    }
    
    func createPopularSection() {
        
        sections.append(categoryFactory.addPopularSection())
        
        
        
    }
    
    func createSpecificSection() {
        
        
        
        
        
    }
    
    func createSpecificSearchSection() {
        
        //  sectionSearches.append()
        
        
    }
    
    func createButtonSection() {
        
        
        sections.append(categoryFactory.addButtons())
        
        
    }
    
    
    
    
    func getSection(row: Int) -> Section {
        
        return sections[row]
        
    }
    
}

class Section {
    
    var sectionType: SectionType
    
    var listing = CategorySearches.hockey
    
    var sectionTitle: String?
    
    var searchID: Int?
    
    var videoList: [Int]?
    
    var buttons: [ThumbnailButton]?
    
    init(sectionType: SectionType, sectionTitle: String?, searchID: Int?, videoList: [Int]?, buttons: [ThumbnailButton]?) {
        
        self.sectionType = sectionType
        
        self.sectionTitle = sectionTitle
        
        self.searchID = searchID
        
        self.videoList = videoList
        
        self.buttons = buttons
        
        
        
    }
    
    
}

enum SectionType {
    
    case buttonNoTitle
    
    case videoList
    
    case buttonWithTitle
    
    case slider
    
    case specificVideoList
    
}


protocol CategoryListing {
    
    var categoryFactory: CategoryFactory {get set}
    
}






class baseballButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "baseball")
        
        self.title = "Baseball"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category()
        
    }
    
}

class hockeyButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "hockey")
        
        self.title = "Hockey"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category()
        
    }
    
}

class ButtonFactory {
    
    var type: ButtonType? = nil
    
    var image: UIImage? = nil
    
    var title: String? = nil
    
    var imageOverlay: String? = nil
    
    var page: String? = nil
    
    var category: Category? = nil
    
    
    func getType() -> ButtonType? {
        
        return type
        
    }
    
    
    func getImage() -> UIImage? {
        
        return image
        
    }
    
    func setImage(url: String) {
        
        let escapedString = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let url = NSURL(string: escapedString! )
        
        if(url != nil) {
            let data = NSData(contentsOf: url! as URL)
            
            self.image = UIImage(data: data! as Data)!
            
        }
        
    }
    
    func getTitle() -> String? {
        
        
        
        return title
        
    }
    
    func getImageOverlay() -> String? {
        
        
        
        
        return imageOverlay
        
    }
    
    func getPage() -> String? {
        
        
        
        return page
    }
    
    func getCategory() -> Category? {
        
        
        
        
        return category
        
    }
    
}



enum ButtonType {
    
    case video
    
    case category
    
    case page
    
}


class Button {
    
    var factory: ButtonFactory
    
    var type: ButtonType?
    
    var image: UIImage?
    
    var imageURL: String?
    
    var title: String?
    
    var imageOverlay: String?
    
    var page: String?
    
    var category: Category?
    
    
    init(factory: ButtonFactory) {
        
        self.factory = factory
        
        self.type = factory.getType()
        
        self.image = factory.getImage()
        
        self.title = factory.getTitle()
        
        self.imageOverlay = factory.getImageOverlay()
        
        self.page = factory.getPage()
        
        self.category = factory.getCategory()
    }
    
}







class VideoSearch : UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    
    
    var categories: [String: CategorySearches] = ["All Categories": CategorySearches.recent, "Hockey": CategorySearches.hockey, "Baseball": CategorySearches.baseball, "Basketball": CategorySearches.basketball, "North Suburban Beat": CategorySearches.nsb, "Concerts": CategorySearches.concerts]
    
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
    
    
    func getCategories() -> [String: CategorySearches] {
        
        
        return categories
        
        
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
    
    
    func searchForSingle(_ savedSearchID: Int)-> [Video] {
        
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
        
        
        var result = trimVideos(videoArray: searchResults, numberToReturn: 1)
        
        return result
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
