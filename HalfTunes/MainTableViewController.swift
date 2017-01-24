//
//  MainTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/25/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit


var category = Category(categoryFactory: CategoryFactory(factorySettings: featuredFactorySettings()))

var featuredCategory = Category(categoryFactory: CategoryFactory(factorySettings: featuredFactorySettings()))

var suggestedSearch : Section?


var search = VideoSearch()




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
        
        self.parentCategory = newCategory
        
        category = self.parentCategory
        
        self.setSliderImages()
        
        self.setSlides()
        
       
    }
    
    

    
    
    func refresh(sender:AnyObject) {
        
        
        
        DispatchQueue.global(qos: .background).async {
            
           
            
            
            DispatchQueue.main.async( execute: {
                
                
                
                self.embeddedViewController?.refreshTable()
                

             
                
                
                self.setSliderImages()
                
                self.setSlides()
                
                
          
                
                //self.generateCategories()
                
               // self.tableView.reloadData()
                
          
                
                
                
            })
            
            
           self.refreshControl?.endRefreshing()
            
            
                
        
        }
        

    
        
    }
 

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        slideShowView.frame.size.height = slideShowView.frame.width / 2.36
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
    
        
        
   
            // Do any additional setup after loading the view, typically from a nib.
            
        
       
        
        
        
        DispatchQueue.global(qos: .background).async {
            
            
            if(categoriesVideos.count == 0) {
          
                self.generateCategories()
                
                
                
                
            }
        }
        
    }
    
    
 
    
    
    
    
    func generateCategories() {
        
        
        var search = VideoSearch()
        
        for video in categories {
            
            video.createListing()
            
            var vid = [Video]()
            
            
            
            if(video.sections.first!.searchID == 1) {
                
                vid = search.getYouTubeVideos(playlist: video.sections.first!.sectionPlaylist!)!
                
                
                
                if (vid.first?.fileName != nil) {
                    
                    
                    
                    
                    if( vid.first?.hasThumbnailUrl())! {
                        
                        
                        print("has thumbnail \(vid.first?.thumbnailUrl) and \(vid.first?.fileName)")
                        
                        
                       
                        
                       search.getThumbnail(url: (vid.first?.thumbnailUrl)!)
                        
                        
                        
                        
                    } else {
                        
                        
                        
                        
                        vid.first?.generateThumbnailUrl()
                        
                        
                        
                       search.getThumbnail(url: (vid.first?.thumbnailUrl)!)
                        
                          print("gebnerated \(vid.first?.thumbnailUrl)")
                        
                    }
                    
                    
                  //  search.getThumbnail(id: (vid.first?.fileName)!)
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
    
    
    func setSlides() {
        
        
        if(parentCategory.slider?.slides != nil) {
            
            vc?.setSlides(slides: (self.parentCategory.slider?.slides)!)
            
        }
        
        
    }
    
    func setSliderImages() {
        
        var slider = self.parentCategory.getSlider()
        
        if(slider != nil) {
            
            if((slider!.images.count) > 0) {
                
                vc?.setSlider(slider: slider!)
                
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        category = self.parentCategory
        
        self.title = self.parentCategory.categoryTitle
        
    }
    
    override func viewDidLayoutSubviews() {
        
        self.setSliderImages()
        
        self.setSlides()
        
      
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        /*
         
         featured = false
         
         if(previousCategory?.categoryTitle == featuredCategory.categoryTitle) {
         
         featured = true
         
         
         }
         
         previousCategory = category
         
         
         
         */
        
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
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
       var embeddedViewController: HorizontalTableViewController?
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        

        
   
            if (segue.identifier == "embedSegue") {
                
                self.embeddedViewController = segue.destination as! HorizontalTableViewController
            }
        
        
        
        if (segue.identifier == "slideShow") {
            vc = segue.destination as! SlideShowViewController
            
            
            
        }
        
        
        
    }
    
    
}
