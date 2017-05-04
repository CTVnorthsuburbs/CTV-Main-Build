//
//  CategoriesTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 11/8/16.
//
//

import UIKit



var categoriesVideos = [Video]()

class CategoriesTableViewController: UITableViewController {
    
    var parentView: MainTableViewController?
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        categories = search.getCategories()
        
        for category in categories {
            
            if(category.sections.first?.images == nil) {
                print("listing created for \(category.categoryTitle)")
                category.createListing()
                
            }
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
     
    }
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return categories.count
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: {})
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(category.categoryTitle   != categories[indexPath.row].categoryTitle ) {
            
            
            DispatchQueue.main.async(){
                
                LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
                
            }
            
            
            category = categories[indexPath.row]
            
            
            
            let parentView =  self.presentingViewController?.childViewControllers.first?.childViewControllers.first as! MainTableViewController
            
            
            parentView.setCategory(newCategory: categories[indexPath.row])
            
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CategoriesTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as? CategoriesTableViewCell
        
        cell?.categoryTitle.text = categories[indexPath.row].categoryTitle
        
        var thumbnail: UIImage?
        
        cell?.thumbnailImage.setRadius(radius: imageRadius)
        
        let categoryTitle = categories[indexPath.row].categoryTitle
        
        cell?.setCategory(category: categories[indexPath.row])
        
        
        print("Count \(categoriesVideos.count) & \(categories.count)")
        
        
        if(categoriesVideos.count == categories.count) {
            
            
            print("gets here for \(categories[indexPath.row].categoryTitle)")
            if( categoriesVideos[indexPath.row].fileName == 1) {
                
                thumbnail = search.getThumbnail(url: (categoriesVideos[indexPath.row].thumbnailUrl)!)
                
            }
            
            
            else if ( categoriesVideos[indexPath.row].fileName == 0) {
                
                thumbnail = categoriesVideos[indexPath.row].thumbnail
                
            }
                
            else {
                
                
                if(categoriesVideos[indexPath.row].fileName != nil) {
                    
                    
                thumbnail = search.getThumbnail(id: (categoriesVideos[indexPath.row].fileName)!)
                    
                }
                
            }
            
        } else {
            
            
            if (categories[indexPath.row].sections.first?.searchID != nil) {
                
                
                print("search for single called from categories table view")
                
                let vid = search.searchForSingleCategory((categories[indexPath.row].sections.first!.searchID)!)
                
                if (vid.first?.fileName != nil) {
                    
                    thumbnail = search.getThumbnail(id: (vid.first?.fileName)!)
                    
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
