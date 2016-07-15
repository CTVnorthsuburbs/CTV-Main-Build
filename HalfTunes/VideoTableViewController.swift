//
//  VideoTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit

class VideoTableViewController: UITableViewController {
    // MARK: Properties
    
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise load sample data.
        if let savedVideos = loadVideos() {
            videos += savedVideos
        } else {
            // Load the sample data.
            loadSampleVideos()
        }
    }
    
    func loadSampleVideos() {
        let photo1 = UIImage(named: "video1")!
        let video1 = Video(title: "Soccer", thumbnail: photo1, fileName: "video1", sourceUrl: "ctv15.org" )!
        
        let photo2 = UIImage(named: "video2")!
        let video2 = Video(title: "Baseball", thumbnail: photo2, fileName: "video2", sourceUrl: "ctv15.org" )!
        
        let photo3 = UIImage(named: "video3")!
        let video3 = Video(title: "Volleyball", thumbnail: photo3, fileName: "video2", sourceUrl: "ctv15.org" )!
        
        videos += [video1, video2, video3]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "VideoTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! VideoCell
        
        // Fetches the appropriate meal for the data source layout.
        let video = videos[indexPath.row]
        
        cell.nameLabel.text = video.title
        cell.photoImageView.image = video.thumbnail
        
        
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            videos.removeAtIndex(indexPath.row)
            saveVideos()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            // Get the cell that generated this segue.
            if let selectedMealCell = sender as? VideoCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = videos[indexPath.row]
               // mealDetailViewController.meal = selectedMeal
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new meal.")
        }
    }
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
       /* if let sourceViewController = sender.sourceViewController as? MealViewController, video = sourceViewController.video {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                videos[selectedIndexPath.row] = video
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: videos.count, inSection: 0)
                videos.append(video)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the meals.
            saveVideos()
        }  */
    }
    
    // MARK: NSCoding
    
    func saveVideos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(videos, toFile: Video.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadVideos() -> [Video]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Video.ArchiveURL.path!) as? [Video]
    }
}
