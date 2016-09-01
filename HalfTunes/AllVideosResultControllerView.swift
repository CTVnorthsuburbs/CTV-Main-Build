//
//  AllVideosResultControllerView.swift
//  HalfTunes
//
//  Created by William Ogura on 8/19/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation


//
//  SearchViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 8/5/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class AllVideosResultsViewController: UITableViewController,  UISearchBarDelegate, UISearchDisplayDelegate {
    
    var searchResults = [Video]()
    
    var myVideos = [Video]()
    
    
    
   var searchBar: UISearchBar!
   
    
    var searchActive : Bool = false
    var data = [String]()
    var filtered:[String] = []
    
    
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
 
    
    
    
    @IBOutlet weak var allVideosResults: UIView!
    
    
    
    
    
    override func viewDidLoad() {
     

        super.viewDidLoad()


        tableView.delegate = self
  
        
        self.tableView.hidden = true
        
    }
    
    
    

    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetails" {
            
            
            print("this one runs")
            
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
    


}


extension AllVideosResultsViewController: NSURLSessionDelegate {
    
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
