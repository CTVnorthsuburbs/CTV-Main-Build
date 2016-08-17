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
    var data = [String]()
    var filtered:[String] = []
    
    
    
    
    
    
    
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
            
            data.append(item.title!)
            
        }

        
        //let url = NSURL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/?search=baseball&include=vod,thumbnail")

        // let url = NSURL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/?search=\(searchTerm)&include=vod,thumbnail")

        super.viewDidLoad()
        
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
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
        
        filtered = data.filter({ (text) -> Bool in
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
        return data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row];
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
