//
//  VideoTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit

class MyVideosStaticViewController: UITableViewController {
    // MARK: Properties
    
    @IBOutlet weak var myTableView: UITableView!
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = myTableView
        
       // myTableView.delegate = self
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved videos, otherwise load sample data.
        if let savedVideos = loadVideos() {
            videos += savedVideos
        } else {
            // Load the sample data.
            loadSampleVideos()
        }
    }
    
    func loadSampleVideos() {
        let photo1 = UIImage(named: "meal1")!
        let video1 = Video(title: "Soccer", thumbnail: photo1, fileName: "video1", sourceUrl: "ctv15.org" )!
        
        let photo2 = UIImage(named: "meal2")!
        let video2 = Video(title: "Baseball", thumbnail: photo2, fileName: "video2", sourceUrl: "ctv15.org" )!
        
        let photo3 = UIImage(named: "meal3")!
        let video3 = Video(title: "Volleyball", thumbnail: photo3, fileName: "video3", sourceUrl: "ctv15.org" )!
        
        videos += [video1, video2, video3]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
 func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "VideoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! VideoCell
        
        // Fetches the appropriate video for the data source layout.
        let video = videos[indexPath.row]
        
        cell.titleLabel.text = video.title
        cell.thumbnailView.image = video.thumbnail
        cell.fileNameLabel.text = video.fileName
        
        
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            videos.remove(at: indexPath.row)
            saveVideos()
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        } else if editingStyle == .insert {
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
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let videoDetailViewController = segue.destination as! VideoViewController
            
            // Get the cell that generated this segue.
            if let selectedVideoCell = sender as? VideoCell {
                let indexPath = tableView.indexPath(for: selectedVideoCell)!
                let selectedVideo = videos[indexPath.row]
                videoDetailViewController.video = selectedVideo
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new video.")
        }
    }
    
    /*
    @IBAction func unwindToVideoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? VideoViewController, let video = sourceViewController.video {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing video.
                videos[selectedIndexPath.row] = video
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new video.
                let newIndexPath = NSIndexPath(index: videos.count)
                videos.append(video)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
            }
            // Save the videos.
            saveVideos()
        }
    }
 */
    
    // MARK: NSCoding
    
    func saveVideos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(videos, toFile: Video.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save videos...")
        }
    }
    
    func loadVideos() -> [Video]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
    }
}
