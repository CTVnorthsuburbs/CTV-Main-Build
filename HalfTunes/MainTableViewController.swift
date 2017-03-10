//
//  MainTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/25/16.
//
//

import UIKit


var category = Category(categoryFactory: CategoryFactory(factorySettings: home()))

var featuredCategory = Category(categoryFactory: CategoryFactory(factorySettings: home()))

var suggestedSearch : Section?

var upcomingEventsFeed = UpcomingEventsFeed()

var upcomingEvents = [Event]()

var search = VideoSearch()

var updater = Updater()


class MainTableViewController: UITableViewController {
    
    var parentCategory = featuredCategory
    
    @IBOutlet weak var slideShowView: UIView!
    
    @IBOutlet weak var mainTableView: UIView!
    
    @IBOutlet var tableView1: UITableView!
    
    var vc: SlideShowViewController?
    
    convenience init() {
        
        self.init()
        
        category = self.parentCategory
        
    }
    
    
    func setCategory(newCategory: Category) {
        
        
        if(newCategory.categoryTitle == featuredCategory.categoryTitle) {
            
            
            self.parentCategory = featuredCategory
            
            category = self.parentCategory
            
            
        } else {
            
            self.parentCategory = newCategory
            
            category = self.parentCategory
            
        }
        
        self.setSlider()
        
    }
    
    
    
    func setSlider() {
        
        let slider = parentCategory.getSlider()
        
        vc?.setSlider(slider: slider!)
        
    }
    
    
    func loadSearch() {
        
        
                //perform search list update in background in order to have instant access to search results, it has been pulled to decrease initial load activity and it did not seem to work correctly
            
                       searchResults = search.getRecent()
            
          /*
            let myData = NSKeyedArchiver.archivedData(withRootObject: searchResults)
            
            let defaults = UserDefaults.standard
            
            defaults.set(myData, forKey: "SavedVideoSearchList")
 
 */
            
                print("seartch results from maintable \(searchResults.count)")
            
            
            
        
 
    
        
        
    }
    
    
    func refresh(sender:AnyObject) {
        
        DispatchQueue.global(qos: .background).async {
            
            DispatchQueue.main.async( execute: {
                
                self.embeddedViewController?.refreshTable()
                
                self.update()
                
            })
            
            self.refreshControl?.endRefreshing()
            
        }
        
    }
    
    func update() {
        
        var updatedSlider: Section?
        
        DispatchQueue.global(qos: .background).async {
            
            updatedSlider = updater.getSlideShowUpdate()
            
            if(updatedSlider != nil) {
                
                DispatchQueue.main.async {
                    
                    if(self.parentCategory.categoryTitle == featuredCategory.categoryTitle) {
                        
                        self.parentCategory.slider = updatedSlider
                        
                        featuredCategory.slider = updatedSlider
                        
                    }
                    
                    self.setSlider()
                    
                }
                
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        slideShowView.frame.size.height = slideShowView.frame.width / 2.36
        
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        
        DispatchQueue.global(qos: .background).async {
            
            if(categoriesVideos.count == 0) {
                
                self.generateCategories()
                
            }

            self.update()
            
             self.loadSearch()
            
        }


    }
    
    
    
    func generateCategories() {
        
        
        for video in categories {
            
            video.createListing()
            
            var vid = [Video]()
            
            
            if(video.sections.first!.searchID == 1) {
                
                vid = search.getYouTubeVideos(playlist: video.sections.first!.sectionPlaylist!)!
                
                if (vid.first?.fileName != nil) {
                    
                    if( vid.first?.hasThumbnailUrl())! {
                        
                        search.getThumbnail(url: (vid.first?.thumbnailUrl)!)
                        
                    } else {
                        
                        vid.first?.generateThumbnailUrl()
                        
                        search.getThumbnail(url: (vid.first?.thumbnailUrl)!)
                        
                    }

                    categoriesVideos.append(vid.first!)
                    
                }
                
            } else {
                
                vid = search.searchForSingleCategory((video.sections.first!.searchID)!)
                
                if (vid.first?.fileName != nil) {
                    
                    search.getThumbnail(id: (vid.first?.fileName)!)
                    
                    categoriesVideos.append(vid.first!)
                    
                }
                
            }
            
            
        }
        
        refreshControl?.endRefreshing()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        category = self.parentCategory
        
        self.title = self.parentCategory.categoryTitle
        
        
    }
    
    
    func categoryPressed() {
        
        self.performSegue(withIdentifier: "categoryPressed", sender: self)
        
    }
    
    func changeSize(height: Int) {
        
        mainTableView.frame.size.height = CGFloat(height)
        
        self.tableView1.layoutMarginsDidChange()
        
        self.tableView1.reloadData()
        
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
        
        if(vc != nil) {
            
            vc?.resetSlidePosition()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        
        searchResults.removeAll()
        
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    
    var embeddedViewController: HorizontalTableViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "embedSegue") {
            
            self.embeddedViewController = segue.destination as? HorizontalTableViewController
            
        }
        
        if (segue.identifier == "slideShow") {
            
            vc = segue.destination as? SlideShowViewController
            
        }

    }

}
