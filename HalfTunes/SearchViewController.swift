//
//  SearchViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 8/5/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
      var searchResults = [Video]()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    
    
    var searchActive : Bool = false
    var data1 = [String]()
    var filtered:[String] = []
    
    
    
    
    
    
    
    func getNSURLSession() -> NSURLSession {
        
        let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        return defaultSession
    
    }
    
    
    func getSearchResults(defaultSession: NSURLSession, url: NSURL, isIDSearchURL: Bool) -> [Int]? {
        
        var dataTask: NSURLSessionDataTask?
        
        var results : [Int]?
        

        
        if dataTask != nil {
            dataTask?.cancel()
        }
   
        
        dataTask = defaultSession.dataTaskWithURL(url) {
            
            data, response, error in
         
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
   
            }
            // 7
            if let error = error {
                print(error.localizedDescription)
                
                
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    
                    
                    if (isIDSearchURL == true) {
                        
                     
                        
                         self.updateSearchResults(data)
                        
                    } else {
                        
          
                        
                     results = self.getSavedSearchResults(data)!
          
                    

                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                        //self.tableView.setContentOffset(CGPointZero, animated: false)    this closes the searchbar but is broken
                    }
                 
                }
                
            }
            
        }
        
               dataTask?.resume()
        
        while (results == nil && isIDSearchURL != true) {
            
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
        
        print(searchURL)
        
       return searchURL
        
    }
    
    
    override func viewDidLoad() {
      /*
        
        var session = getNSURLSession()
        
          let searchUrl = NSURL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/search/advanced/savedshowsearch/?id=52966")
        
        var results = getSearchResults(session, url: searchUrl!, isIDSearchURL: false)
        
      
       var searchIdURL =  convertIdArrayToSearchURL(results!)
        
        
        getSearchResults(session, url: searchIdURL!, isIDSearchURL: true)
        
    
        */
        
        
        
        let videoSearch = VideoSearch()
        
        //searchResults = videoSearch.getSport("baseball")
        
        
        searchResults = videoSearch.getRecent()
        
        

        
        for item in searchResults {
            
            data1.append(item.title!)
            
        }

        
        //let url = NSURL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/?search=baseball&include=vod,thumbnail")

        // let url = NSURL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/?search=\(searchTerm)&include=vod,thumbnail")

        super.viewDidLoad()
        
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
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
    
    
    
    
    
    
    
    
    
    
    
    
    func updateSearchResults(data: NSData?) {
        searchResults.removeAll()
        

        
        
        var json: [String: AnyObject]!
        
        
        do {
            
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
            
        } catch {
            
            print(error)
            
        }
        
        guard let VideosResult = VideosResult(json: json) else {
            
            return
            
        }
        
        guard VideosResult.show != nil else {
            
            return
            
        }
        
        guard let vod = VideosResult.vod!.first else {
            
            return
            
        }
        
   
        
        
        //MARK: May not work

        for show in VideosResult.show! {
            
            
            
            searchResults.append(Video(title: show.title, thumbnail: nil, fileName: vod.fileName, sourceUrl: vod.url)!)
            
        }
        
        // searchResults.append(Video(title: show.title, thumbnail: nil, fileName: vod.fileName, sourceUrl: vod.url)!)
        
        
        
        
        for show in searchResults {
            
            
            
            data1.append( show.title!)
            print(show.title)
            
        }

      
    }
    

    
    
    
    
    
    
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data1.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data1.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data1[indexPath.row];
        }
        
        return cell;
    }
}


extension SearchViewController: NSURLSessionDelegate {
    
    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            if let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler()
                })
            }
        }
    }
}
