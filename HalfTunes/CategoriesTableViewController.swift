//
//  CategoriesTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 11/8/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var currentCategory = category
    
    
    
    var categories =  [Category]()
    
    
    var search = VideoSearch()
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
         categories = search.getCategories()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
       
        
        currentCategory = categories[indexPath.row]
        
        performSegue(withIdentifier: "unwindToMenu", sender: self)

     //   parentVC.changeTableSize()
        
        
    }
    

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CategoriesTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as? CategoriesTableViewCell

       //  let sortedKeys = Array(self.categories.keys).sorted()
        
        cell?.categoryTitle.text = categories[indexPath.row].categoryTitle
        
              var thumbnail: UIImage?
        
        cell?.thumbnailImage.setRadius(radius: imageRadius)
        
        
    
        
       //generate thumbnail in bacground
       
       
        
        
            let categoryTitle = categories[indexPath.row].categoryTitle
            
        
        //    let searchID = self.categories[categoryTitle]
        
     
        
        
                    cell?.setCategory(category: categories[indexPath.row])
        
        
        
        
    
            
        if (categoryTitle == currentCategory.categoryTitle) {
            
            cell?.categoryTitle.isHighlighted = true
            
            cell?.accessoryType = .checkmark
            
            
         
            
        } else {
            
            cell?.categoryTitle.isHighlighted = false
            
            cell?.accessoryType = .none
        }
        
        
        

        
        //   let recentVideo = self.search.searchForSingle((categories[indexPath.row].sections[0].searchID)!)
            
     
        
        
      
         //      thumbnail = self.search.getThumbnail(id: (recentVideo.first?.fileName)!)
                
            
                
            
     
            
    
                
                if(thumbnail != nil ) {
                    
                    cell?.thumbnailImage.image = thumbnail
                    
                    
                    
                } else {
                    cell?.thumbnailImage.image = #imageLiteral(resourceName: "defaultPhoto")
                }
                
                
                
        
            
        

        
        return cell!
    }
    
    

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

    
    
    
 

}
