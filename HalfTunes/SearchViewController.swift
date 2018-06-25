//
//  SearchViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 8/5/16.
//
//

import UIKit

var searchResults = [Video]()

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchExamplesView: UIView!
    
    @IBOutlet weak var hockeyButton: UIButton!
    
    @IBOutlet weak var rahsButton: UIButton!
    
    @IBOutlet weak var boysSoccerButton: UIButton!
    
    @IBOutlet weak var girlsSwimmingButton: UIButton!
    
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var moundsViewButton: UIButton!
    
    @IBOutlet weak var lacrosseButton: UIButton!
    
    @IBOutlet weak var myVideoEmptyLabel: UILabel!
    
    var tapRecognizer : UITapGestureRecognizer?
    
    var tableView: UITableView!
    
    var searchActive : Bool = false
    
    var data = [String]()
    
    var filtered:[String] = []
    
    var numberOfAllVideosResults = 11  //Sets the number of results displayed in All Video Search Table
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var myVideosTableView: UITableView!
    
    @IBOutlet weak var allVideosResults: UIView!
    
    @IBOutlet weak var myVideosResults: UIView!
    
    var myVideosChildView : MyVideosSearchViewController?
    
    var childView : AllVideosResultsViewController?
    
    func updateSearchResults(_ searchResults: [Video]) {
        
        for item in searchResults {
            
            self.data.append(item.title!)
            
        }
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        let searchText = sender.titleLabel??.text
        
        searchBar.delegate = self
        
        self.searchBar.text = searchText
        
        self.searchBar(searchBar, textDidChange:searchText!)
        
    }
    
    
    func loadVideos() -> [Video]? {
        
        let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
        
        return  loaded
        
    }
    
    
    override func viewDidLoad() {
        
        childView = self.childViewControllers.first as? AllVideosResultsViewController
        
        myVideosChildView = self.childViewControllers.last as? MyVideosSearchViewController
        
        allVideosResults.isHidden = false
        
        myVideosResults.isHidden = true
        
        let defaults = UserDefaults.standard
        
        var savedResults = [Video]()
        
        let retrievedData = UserDefaults.standard.object(forKey: "searchResults") as? Data           //move all the search stuff out of the controller and into the search class
        
        if( retrievedData != nil) {
            
            savedResults = (NSKeyedUnarchiver.unarchiveObject(with: retrievedData!))! as! [Video]
            
        }
        
        if(savedResults.count != 0) {     //set to != to use saved results when available, otherwise use the video search, == to always search (useful for testing).
            
            print("saved search results retrieved")
            
            //perform search list update in background
            
            searchResults = savedResults
            
            var otherVideos = [Video]()
            
            if(loadVideos() != nil) {
                
                
                otherVideos = loadVideos()!
                
            }
            
            for vid in otherVideos {
                
                searchResults.append(vid)
            }
            
            self.updateSearchResults(searchResults)
            
            
            
            //      self.myVideosChildView!.searchResults = searchResults
            
            print("number of search results retrieved from saved data: \(searchResults.count)")
            
            
            
        } else {
            
            DispatchQueue.global(qos: .userInitiated).async   {
                
                //perform search list update in background
                if(searchResults.count == 0 ) {
                    
                    print("getting new results")
                    
                    searchResults = search.getRecent()
                    
                }
                
                DispatchQueue.main.async {
                    
                    let myData = NSKeyedArchiver.archivedData(withRootObject: searchResults)
                    
                    defaults.set(myData, forKey: "SavedVideoSearchList")
                    
                    self.updateSearchResults(searchResults)
                    
                    print("number of search results retrieved from url: \(searchResults.count)")
                    
                }
                
            }
            
        }
        
        self.myVideosTableView = myVideosChildView!.tableView
        
        self.tableView = childView!.tableView
        
        childView!.searchBar = self.searchBar
        
        childView!.filtered = self.filtered
        
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        self.tableView.isHidden = true
        
        self.myVideosTableView.isHidden = true
        
        self.myVideosChildView?.searchExamplesView = self.searchExamplesView
        
        self.myVideosChildView?.myVideoEmptyLabel = self.myVideoEmptyLabel
        
        myVideoEmptyLabel.isHidden = true
        
        // myVideosChildView!.data = self.searchResults     // Uncomment to replace my videos with full search results, useful for testing
        
        tapRecognizer = UITapGestureRecognizer()
        
        tapRecognizer?.addTarget(self, action: #selector(SearchViewController.didTapView))
        
        searchBar.placeholder = "All Videos"
        
    }
    
    func didTapView(){
        
        self.view.endEditing(true)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        indexChanged(segmentedControl)
        
        
    }
    
    func setMyVideoView() {
        
        segmentedControl.selectedSegmentIndex = 1
        
        indexChanged(segmentedControl)
        
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex
            
        {
            
        case 0:
            
            searchBar.placeholder = "All Videos"
            
            self.view.addGestureRecognizer(tapRecognizer!)
            
            let searchText = searchBar.text             //get current search text, change the delgate, then add the text
            
            searchBar.delegate = self
            
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
            
            searchBar.placeholder = "My Videos"
            
            let searchText = searchBar.text             //get current search text, change the delgate, then add the text
            
            searchBar.delegate = myVideosChildView
            
            myVideoEmptyLabel.isHidden = false
            
            self.view.removeGestureRecognizer(tapRecognizer!)
            
            if(searchText!.isEmpty == false) {
                
                myVideosChildView?.searchBar(searchBar, textDidChange:searchText!)
                
                searchExamplesView.isHidden = true
                
            } else {
                
                myVideosChildView?.searchBar(searchBar, textDidChange:"")
                
                searchExamplesView.isHidden = true
                
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
        
        self.childView?.searchBar.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.characters.count == 0) {
            
            searchExamplesView.isHidden = false
            
            myVideoEmptyLabel.isHidden = true
            
            self.tableView.isHidden = true
            
            self.view.addGestureRecognizer(tapRecognizer!)
            
        } else {
            
            myVideoEmptyLabel.isHidden = true
            
            searchExamplesView.isHidden = true
            
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
        
        searchResults.removeAll()
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
            self.view.removeGestureRecognizer(tapRecognizer!)
            
            
            cell.textLabel?.text = filtered[(indexPath as NSIndexPath).row]
            
        } else {
            
            cell.textLabel?.text = data[(indexPath as NSIndexPath).row]
            
        }
        
        return cell
        
    }
    
}



