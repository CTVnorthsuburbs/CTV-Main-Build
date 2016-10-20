//
//  SuggestedVideosTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/20/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class SuggestedVideosTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
         recommendedVideos = search.getRecentLimited()
        
        
        myVideos = recommendedVideos
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var myVideos = [Video]()
   
    
    var search = VideoSearch()
    
    var recommendedVideos = [Video]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("runs beofe selector")
        if segue.identifier == "ShowDetail" {
            
            print("this segue runs")
            
            let videoDetailViewController = segue.destination as! VideoViewController
            
            // Get the cell that generated this segue.
            
            if let selectedVideoCell = sender as? VideoCell {
                
                let indexPath = tableView.indexPath(for: selectedVideoCell)!
                
                
                let selectedVideo = myVideos[indexPath.row]
                
                videoDetailViewController.video = selectedVideo
                
                //    videoDetailViewController.setActiveDownloads(downloads: &activeDownloads)
                
                
                //         videoDetailViewController.setDefaultSession(defaultSession: &defaultSession)
                
                //         videoDetailViewController.setDataTask(dataTask: &dataTask)
                
                
                //     videoDetailViewController.setDownloadsSession(downloadsSession: &downloadsSession)
                
            }
            
        }
            
        else if segue.identifier == "AddItem" {
            
            print("Adding new video.")
            
        }
        
    }
    
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as? MainVideoCell
        
        
        cell?.titleLabel?.text = recommendedVideos[indexPath.row].title
        
        cell?.thumbnailView.image = recommendedVideos[indexPath.row].thumbnail
        
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.low).async {  //generate thumbnail in bacground
            
            do {
                
                
                
                //  self.recommendedVideos[indexPath.row].generateThumbnail()
                self.recommendedVideos[indexPath.row].thumbnail =  self.search.getThumbnail(id: self.recommendedVideos[indexPath.row].fileName! )
                
                
                
                
                
            } catch {
                self.recommendedVideos[indexPath.row].thumbnail = nil
            }
            
            
            
            
            
            
            DispatchQueue.main.async {
                
                cell?.thumbnailView.image =  self.recommendedVideos[indexPath.row].thumbnail
                
                
            }
            
        }
        return cell!
        
        
    }
    
    
    /*
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return "Section \(section)"
     }
     */
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recommendedVideos.count
    }
    
    
    
    

}
