//
//  CategoriesTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 11/8/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var currentCategory = Category.recent.rawValue
    
    
    
    var categories: [String: Category] = ["All Categories": Category.recent, "Hockey": Category.hockey, "Baseball": Category.baseball, "Basketball": Category.basketball, "North Suburban Beat": Category.nsb, "Concerts": Category.concerts]
    
    
    
    var search = VideoSearch()
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CategoriesTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as? CategoriesTableViewCell

         let sortedKeys = Array(self.categories.keys).sorted()
        
        cell?.categoryTitle.text = sortedKeys[indexPath.row]
        
              var thumbnail: UIImage?
        
        cell?.thumbnailImage.setRadius(radius: imageRadius)
        
       //generate thumbnail in bacground
       
       
        
        
            let categoryTitle = sortedKeys[indexPath.row]
            
        
            let searchID = self.categories[categoryTitle]
        
            
            
        if (searchID?.rawValue == currentCategory) {
            
            cell?.categoryTitle.isHighlighted = true
            
            cell?.accessoryType = .checkmark
            
            
        } else {
            
            cell?.categoryTitle.isHighlighted = false
            
            cell?.accessoryType = .none
        }
        
        
        

        
            let recentVideo = self.search.searchForSingle((searchID?.rawValue)!)
            
     
        
        
      
                thumbnail = self.search.getThumbnail(id: (recentVideo.first?.fileName)!)
                
            
                
            
     
            
    
                
                if(thumbnail != nil ) {
                    
                    cell?.thumbnailImage.image = thumbnail
                    
                    
                    
                } else {
                    cell?.thumbnailImage.image = #imageLiteral(resourceName: "defaultPhoto")
                }
                
                
                
        
            
        

        
        return cell!
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
