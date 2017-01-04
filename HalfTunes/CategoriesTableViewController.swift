//
//  CategoriesTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 11/8/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

//    var categories =  [Category]()

var categoriesVideos = [Video]()

class CategoriesTableViewController: UITableViewController {
    
    

    var parentView: MainTableViewController?
    
    var search = VideoSearch()
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        categories = search.getCategories()
        
        for category in categories {
            
            if(category.sections.first?.images == nil) {
                
               category.createListing()
                
            }
           // category.createListing()
            
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
      //  tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return categories.count
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: {})
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(category.categoryTitle   != categories[indexPath.row].categoryTitle ) {
            
            category = categories[indexPath.row]
            
            
            
        //    let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "home") as! MainTableViewController
            
         //   vc.setCategory(newCategory: (categories[indexPath.row]))
            
          let parentView =  self.presentingViewController?.childViewControllers.first?.childViewControllers.first as! MainTableViewController
            
            
            parentView.setCategory(newCategory: categories[indexPath.row])
            
            
           
          
            
            //currentCategory = categories[indexPath.row]
            
            
         //    let tc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            
            
         //   self.navigationController?.pushViewController(tc, animated:true)
            
            
            
         //   self.navigationController?.pushViewController(vc, animated:true)
            
            
            
        //  self.navigationController?.show(vc, sender: nil)
            
            
        }
        
          self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CategoriesTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as? CategoriesTableViewCell
        
        //  let sortedKeys = Array(self.categories.keys).sorted()
        
        cell?.categoryTitle.text = categories[indexPath.row].categoryTitle
        
        var thumbnail: UIImage?
        
        cell?.thumbnailImage.setRadius(radius: imageRadius)
        
        
        let categoryTitle = categories[indexPath.row].categoryTitle
        
        
        cell?.setCategory(category: categories[indexPath.row])
        
        
        
        
        if(categoriesVideos.count == categories.count) {
            
           thumbnail = self.search.getThumbnail(id: (categoriesVideos[indexPath.row].fileName)!)
            
            
        } else {
        
     
        if (categories[indexPath.row].sections.first?.searchID != nil) {
            
            
            
            var vid = search.searchForSingleCategory((categories[indexPath.row].sections.first!.searchID)!)
            
            
            
            
            if (vid.first?.fileName != nil) {
                
                
                print("GETTTING STHUMBNAIL")
                thumbnail = self.search.getThumbnail(id: (vid.first?.fileName)!)
                categoriesVideos.append(vid.first!)

                
            }
            
        }
        
        
        }
        
        
        
        
        
        if (categoryTitle == category.categoryTitle) {
            
            cell?.categoryTitle.isHighlighted = true
            
            cell?.accessoryType = .checkmark
            
            
            
            
        } else {
            
            cell?.categoryTitle.isHighlighted = false
            
            cell?.accessoryType = .none
        }
        
        if(thumbnail != nil ) {
            
            cell?.thumbnailImage.image = thumbnail
            
            
            
        } else {
            cell?.thumbnailImage.image = #imageLiteral(resourceName: "defaultPhoto")
        }
        
        
        
        
        
        
        
        
        return cell!
    }
    
    
    
    
    
    
    
}
