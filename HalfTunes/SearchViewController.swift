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
    
    var myVideos = getSampleVideos()
    
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var searchActive : Bool = false
    var data = [String]()
    var filtered:[String] = []
    
    
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var allVideosResults: UIView!
    
    var childView : AllVideosResultsViewController?
    
    override func viewDidLoad() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
         
      
        var savedResults = [Video]()
        
        let retrievedData = NSUserDefaults.standardUserDefaults().objectForKey("SavedVideoSearchList") as? NSData           //move all the search stuff out of the controller and into the search class
        
        if( retrievedData != nil) {
            
              savedResults = NSKeyedUnarchiver.unarchiveObjectWithData(retrievedData!) as? [Video] ?? [Video]()
            
        
        }
      
        
        if(savedResults.count != 0) {     //set to != to use saved results, == to always search
            
            
            searchResults = savedResults
            
            print("saved search results retrieved")
            
            let dataToSave = NSKeyedArchiver.archivedDataWithRootObject(savedResults)
            
            defaults.setObject(dataToSave, forKey: "SavedVideoSearchList")
            
        } else {
            
            
            print("video search called")
            let videoSearch = VideoSearch()
            
            //searchResults = videoSearch.getSport("baseball")
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {                 //perform search list update in background
                // do your task
                
                self.searchResults = videoSearch.getRecent()
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    
                    print("task finished: \(self.searchResults.count)")
                }
            }
        
            
              print("final count of returned results \(searchResults.count)")
              let myData = NSKeyedArchiver.archivedDataWithRootObject(searchResults)
        defaults.setObject(myData, forKey: "SavedVideoSearchList")
            
       
        }
    
    
        
        
        childView = self.childViewControllers.last as? AllVideosResultsViewController
 
        self.tableView = childView!.tableView
        childView!.searchBar = self.searchBar
        
    
        
        
        for item in searchResults {
            
            data.append(item.title!)

        }
        
        print("number of search results retrieved: \(searchResults.count)")

        childView!.searchResults = self.searchResults
        
     childView!.data = self.data
        childView!.filtered = self.filtered
        
        childView!.myVideos = self.myVideos

        super.viewDidLoad()
        
        // Setup delegates
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        self.tableView.hidden = true
        
    }
    
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        
        
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            
            data.removeAll()
            
            for item in searchResults {
                
                data.append(item.title!)
                
            }
            
            
            
            filtered = data.filter({ (text) -> Bool in
                let tmp: NSString = text
                let range = tmp.rangeOfString(searchBar.text!, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            })
            
            
            childView!.filtered = self.filtered
            
            if(filtered.count == 0){
                searchActive = true;   //true results in table only appearing when search is active (only after initial search is made)
            } else {
                searchActive = true;
            }
            self.tableView.reloadData()
            
            
            
            
            
        case 1:
            
            data.removeAll()
            
           
            
            for item in myVideos {
                
                

                data.append(item.title!)
                
                
                
            }
            
            
            

            
            filtered = data.filter({ (text) -> Bool in
                let tmp: NSString = text
                let range = tmp.rangeOfString(searchBar.text!, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            })
            
            
            
            childView!.filtered = self.filtered
            
            
            if(filtered.count == 0){
                searchActive = true;   //true results in table only appearing when search is active (only after initial search is made)
            } else {
                searchActive = true;
            }
    
     
                self.tableView.reloadData()
            
            
        default:
            break;
        }
        
        
        
    }
    
    
    
    

 
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
       
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.characters.count == 0) {
            self.tableView.hidden = true
        } else {
      
        self.tableView.hidden = false
            
        }
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        
        childView!.filtered = self.filtered
        if(filtered.count == 0){
            searchActive = true;  //true results in table only appearing when search is active (only after initial search is made)
        } else {
            searchActive = true
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
        

        return data.count   //use data.count to always display intial table of all searchResults
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell;
        if(searchActive){
            
            cell.textLabel?.text = filtered[indexPath.row]
    
        } else {
            cell.textLabel?.text = data[indexPath.row]
          
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
