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
 var tableView: UITableView!

    var searchActive : Bool = false
    var data = [String]()
    var filtered:[String] = []
    
    
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    
    
  var myVideosTableView: UITableView!

    
    

    @IBOutlet weak var allVideosResults: UIView!
    
    
    @IBOutlet weak var myVideosResults: UIView!
    
    
    var myVideosChildView : VideoTableViewController?
  
    
    var childView : AllVideosResultsViewController?
    
    
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetails1" {
            
            
            print("segue runs")
            
            let videoDetailViewController = segue.destinationViewController as! VideoViewController
            
            // Get the cell that generated this segue.
            if let selectedVideoCell = sender {
                
                let indexPath = tableView.indexPathForCell(selectedVideoCell as! UITableViewCell)!
                
                var count = 0  //code to map filtered result position to searchResult position
                
                for result in searchResults {
                    
                    if (filtered[indexPath.row] == result.title) {
                        
                        let selectedVideo = searchResults[count]
                        
                        videoDetailViewController.video = selectedVideo
                        
                    }
                    
                    count += 1
                }
                
            }
            
        }
        
    }
    

    

    
    
    
    
    
    

        
        
        
    
    override func viewDidLoad() {
        
        
        
        allVideosResults.hidden = false
        myVideosResults.hidden = true
        
        
        
        
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
                    
                    print("final count of returned results \(self.searchResults.count)")
                    let myData = NSKeyedArchiver.archivedDataWithRootObject(self.searchResults)
                    defaults.setObject(myData, forKey: "SavedVideoSearchList")
                }
            }
        
            
  
            
       
        }
    
    
        
        
        childView = self.childViewControllers.first as? AllVideosResultsViewController
        
        
        
        myVideosChildView = self.childViewControllers.last as? VideoTableViewController
        
                self.myVideosTableView = myVideosChildView!.tableView
        
 
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
        
        
        
        
        
        myVideosChildView!.searchResults = self.searchResults
        

        super.viewDidLoad()
        
        // Setup delegates
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        self.tableView.hidden = true
        self.myVideosTableView.hidden = true
    
        
                myVideosChildView!.data = self.searchResults     //overrides myVideos list
        
        
        

        
    }
    
    
    
       
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            
            
            let searchText = searchBar.text             //get current search text, change the delgate, then add the text
            
        
              searchBar.delegate = self
            
            if(searchText!.isEmpty == false) {
       

          self.searchBar(searchBar, textDidChange:searchText!)
                
                
                
            } else {
                
                
                  self.searchBar(searchBar, textDidChange:"")
            }
            
            
           
             if ((searchBar.text ) != nil) {
                
                
                
                allVideosResults.hidden = false
                
             } else {
                
                
                
                allVideosResults.hidden = true
             }
             
             
 
            myVideosResults.hidden = true
        case 1:
            
            
            
            
            
            let searchText = searchBar.text             //get current search text, change the delgate, then add the text
            
            searchBar.delegate = myVideosChildView
            if(searchText!.isEmpty == false) {
    
              myVideosChildView?.searchBar(searchBar, textDidChange:searchText!)

            } else {
                
                
                   myVideosChildView?.searchBar(searchBar, textDidChange:"")
                
            }
            
            
            
 
            
            if ((searchBar.text ) != nil) {
                
                
                  myVideosResults.hidden = false
                
            } else {
                
                  myVideosResults.hidden = true
                
            }
            
            
            
           allVideosResults.hidden = true
            
        
            
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
