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

class MainTableViewController: UITableViewController {
    
    
    
    var category1 = featuredCategory

    @IBOutlet weak var slideShowView: UIView!
    
    @IBOutlet weak var mainTableView: UIView!
    
    @IBOutlet var tableView1: UITableView!
    
    var vc: SlideShowViewController?

    
    
    
    convenience init() {
        
        self.init()
        
        
        
       category = self.category1
        
    }
    
    
    
    
    
    init(category: Category) {
        
        
        self.category1 = category
        
        
        
        
       super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        
        self.category1 = featuredCategory
        
        super.init(coder: aDecoder)
    }
    
    
    func setCategory(newCategory: Category) {
        
        
        
        self.category1 = newCategory
        
        category = self.category1
        
        
        
        self.setSliderImages()
        
        self.setSlides()
        
       
        
    }
    

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

       
        slideShowView.frame.size.height = slideShowView.frame.width / 2.36
        
        

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
            
            
            
            var vid = search.searchForSingleCategory((video.sections.first!.searchID)!)
            
            
            
            
            if (vid.first?.fileName != nil) {
                
                search.getThumbnail(id: (vid.first?.fileName)!)
                categoriesVideos.append(vid.first!)
                
                
            }
        }
        
        

        
        
        
    }
    
    
    func setSlides() {
        
        
        if(category1.slider?.slides != nil) {
        vc?.setSlides(slides: (self.category1.slider?.slides)!)
            
        }
        
        
    }
    
    func setSliderImages() {
        
        var slider = self.category1.getSlider()
       
        
        
        
     
      
        
        if(slider != nil) {
            
     
            
            
        if((slider!.images.count) > 0) {
            
     
            vc?.setSlider(slider: slider!)
            
            
            
        }
        }
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        category = self.category1
        
        
        
        
        /*

        if (featured == true) {
            
            
            category = featuredCategory
            featured = false
            
            
            
        } else {
            
           //previousCategory = featuredCategory
            featured = true
           // previousCategory = featuredCategory
            
        }
        
*/

     self.title = self.category1.categoryTitle
        

        
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


    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        

        
   
        if (segue.identifier == "slideShow") {
            vc = segue.destination as! SlideShowViewController
            
            
            
        }
        

        
    }


}
