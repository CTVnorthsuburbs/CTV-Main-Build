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
    
    var myVideos = [Video]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tableView: UITableView!

    var searchActive : Bool = false
    
    var data = [String]()
    
    var filtered:[String] = []
    
    var numberOfAllVideosResults = 11  //Sets the number of results displayed in All Video Search Table
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var myVideosTableView: UITableView!

    @IBOutlet weak var allVideosResults: UIView!
    
    @IBOutlet weak var myVideosResults: UIView!
    
    var myVideosChildView : MyVideosViewController?
  
    var childView : AllVideosResultsViewController?
    
    @IBOutlet weak var searchExamples: UILabel!
    
    @IBOutlet weak var searchExampleTitle: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetails" {
            
            let videoDetailViewController = segue.destination as! VideoViewController
            
            // Get the cell that generated this segue.
            
            if let selectedVideoCell = sender {
                
                let indexPath = tableView.indexPath(for: selectedVideoCell as! UITableViewCell)!
                
                var count = 0  //code to map filtered result position to searchResult position
                
                for result in searchResults {
                    
                    if (filtered[(indexPath as NSIndexPath).row] == result.title) {
                        
                        let selectedVideo = searchResults[count]
                        
                        videoDetailViewController.video = selectedVideo
                        
                    }
                    
                    count += 1
                }
                
            }
            
        }
        
    }
    
    func updateSearchResults(_ searchResults: [Video]) {
        
        for item in searchResults {
            
            self.data.append(item.title!)
            
        }
    }

    override func viewDidLoad() {
        
        searchExamples.text = "Lacrosse\n\nHockey\n\nRAHS\n\nBoys Soccer\n\nGirls Hockey\n\n16-01-22\n\nMounds View"
        
        allVideosResults.isHidden = false
        
        
        myVideosResults.isHidden = true
        
        let defaults = UserDefaults.standard
        
        var savedResults = [Video]()
        
        let retrievedData = UserDefaults.standard.object(forKey: "SavedVideoSearchList") as? Data           //move all the search stuff out of the controller and into the search class
        
        if( retrievedData != nil) {
            
              savedResults = NSKeyedUnarchiver.unarchiveObject(with: retrievedData!) as? [Video] ?? [Video]()
        
        }
      
        if(savedResults.count != 0) {     //set to != to use saved results when available, otherwise use the video search, == to always search (useful for testing).
            
            searchResults = savedResults
            
            print("saved search results retrieved")
            
            let dataToSave = NSKeyedArchiver.archivedData(withRootObject: savedResults)
            
            defaults.set(dataToSave, forKey: "SavedVideoSearchList")
            
            updateSearchResults(searchResults)
            
            
        } else {
            
            print("video search called")
            
            let videoSearch = VideoSearch()
            
            //searchResults = videoSearch.getSport("baseball")
            
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {                 //perform search list update in background
                
                self.searchResults = videoSearch.getRecent()
                
                DispatchQueue.main.async {
            
                    print("final count of returned results \(self.searchResults.count)")
                    
                    let myData = NSKeyedArchiver.archivedData(withRootObject: self.searchResults)
                    
                    defaults.set(myData, forKey: "SavedVideoSearchList")
                    
                    self.updateSearchResults(self.searchResults)
            
                
                    
                }
                
            }
            
            

        }
    
        childView = self.childViewControllers.first as? AllVideosResultsViewController
        
        myVideosChildView = self.childViewControllers.last as? MyVideosViewController
        
        self.myVideosTableView = myVideosChildView!.tableView
        
        self.tableView = childView!.tableView
        
        childView!.searchBar = self.searchBar
        
        print("number of search results retrieved: \(searchResults.count)")

        childView!.searchResults = self.searchResults
        
        //childView!.data = self.data
        
        childView!.filtered = self.filtered
        
      //  childView!.myVideos = self.myVideos

        myVideosChildView!.searchResults = self.searchResults

        super.viewDidLoad()
        
        // Setup delegates
        tableView.delegate = self
        
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        self.tableView.isHidden = true
        
        self.myVideosTableView.isHidden = true
        
        self.myVideosChildView?.searchExamples = self.searchExamples
        
        self.myVideosChildView?.searchExampleTitle = self.searchExampleTitle
        
        // myVideosChildView!.data = self.searchResults     // Uncomment to replace my videos with full search results, useful for testing


        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex
            
        {
            
        case 0:
            
            let searchText = searchBar.text             //get current search text, change the delgate, then add the text
            
            searchBar.delegate = childView
            
            if(searchText!.isEmpty == false) {
       
            self.searchBar(searchBar, textDidChange:searchText!)
                
            } else {
                
                self.searchBar(searchBar, textDidChange:"")
                
            }
            
            if ((searchBar.text ) != nil) {
                
                allVideosResults.isHidden = false
                
             } else {
                
                allVideosResults.isHidden = true
                
             }
            
            myVideosResults.isHidden = true
            
        case 1:
            
            let searchText = searchBar.text             //get current search text, change the delgate, then add the text
            
            searchBar.delegate = myVideosChildView
            
            if(searchText!.isEmpty == false) {
    
                myVideosChildView?.searchBar(searchBar, textDidChange:searchText!)
                
                searchExamples.isHidden = true
                
                searchExampleTitle.isHidden = true

            } else {
                
                myVideosChildView?.searchBar(searchBar, textDidChange:"")
                
                searchExamples.isHidden = false
                
                searchExampleTitle.isHidden = false
            
            }
            
            if ((searchBar.text ) != nil) {
                
                myVideosResults.isHidden = false
                
            } else {
                
                myVideosResults.isHidden = true
         
            }
            
            allVideosResults.isHidden = true
            
        default:
            
            break;
            
        }
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchActive = true
        
       
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchActive = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        
        searchActive = false
        
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchActive = false
       
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.characters.count == 0) {
            
            searchExamples.isHidden = false
            
            searchExampleTitle.isHidden = false
            
            self.tableView.isHidden = true
            
        } else {
            
            searchExamples.isHidden = true
            
            searchExampleTitle.isHidden = true
      
            self.tableView.isHidden = false
            
        }
        
        filtered = data.filter({ (text) -> Bool in
            
            let tmp: NSString = text as NSString
            
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            
            return range.location != NSNotFound
        })
        
        if (filtered.count > 0) {                       //this limits the results of the autocomplete for all Videos Search
           
            var count = numberOfAllVideosResults
            
            var slice = [String]()
            
            for item in filtered {
                
                if (count > 0) {
                    
                    slice.append(item)
                    
                    count = count - 1
                    
                }
                
            }
            
            filtered = slice
            
        }

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
    
            return filtered.count
            
        }
        
        return data.count   //use data.count to always display intial table of all searchResults
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        
        if(searchActive){
            
            cell.textLabel?.text = filtered[(indexPath as NSIndexPath).row]
    
        } else {
            
            cell.textLabel?.text = data[(indexPath as NSIndexPath).row]
          
        }
        
        return cell
        
    }
    
}



