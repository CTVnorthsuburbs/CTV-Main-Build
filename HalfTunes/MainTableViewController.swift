//
//  MainTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/25/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit


 var category = Category()

class MainTableViewController: UITableViewController {

    @IBOutlet weak var slideShowView: UIView!
    
    
    var currentCategory = CategorySearches.recent
    
   
    
    
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

       
        
        slideShowView.frame.size.height = slideShowView.frame.width / 2.36
        
        
        var button = Button(factory: baseballButtonFactory())
      
        print("button: \(button.title) type: \(button.type)")
        
     //   category.createListing()
        
        
  
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let search = VideoSearch()
        
        
        let categories = search.getCategories()
        
        
        
        
        for (key, value) in categories {
            
            
            if (value.rawValue == currentCategory.rawValue) {
                
                
                
                self.title = key
            }
            
            
            
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        
        var sourceController = segue.source as! CategoriesTableViewController
        
  
        self.currentCategory = sourceController.currentCategory
        
        
        
        
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "categoryPressed" {
            
            let destination = segue.destination as! UINavigationController
            
            
            let categoryViewController = destination.viewControllers[0] as! CategoriesTableViewController
            
            
            categoryViewController.currentCategory = self.currentCategory

        }
        
    }
        
        
    


}
