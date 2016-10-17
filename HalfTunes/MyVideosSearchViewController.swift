//
//  MyVideosViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit


import MediaPlayer


/// The MyVideosViewController class contains the controller that handles the My Videos table view within the Search View





class MyVideosSearchViewController: MyVideosViewController {
    
    
    
    func printVideos() {
        print("videos in my videos:")
        for video in myVideos {
            
            
            print(video.title)
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        myVideos = [Video]()
        
        if(loadVideos() != nil) {
            
            myVideos = (loadVideos())!
            
        }
        
        
  
        _ = self.downloadsSession
        
        tapRecognizer = UITapGestureRecognizer()
        
        tapRecognizer?.addTarget(self, action: "didTapView")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(loadVideos() != nil) {
            
            self.myVideos = loadVideos()!
            
        }
        
        
    
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    printVideos()
        

        
    }
    
    override func thumbnailTapped(_ cell: VideoCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            
            
            
            var video = filtered[(indexPath as NSIndexPath).row]
            
            
            
            if(searchActive){
                
                video = filtered[(indexPath as NSIndexPath).row]
                
                
                
                // cell.textLabel?.text = filtered[indexPath.row]
                
            } else {
                
                  video = myVideos[(indexPath as NSIndexPath).row]
                
            
                
                
            }
            
            print("video to play: \(video.title)")
            
            playVideo(video)
            
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //self.view.removeGestureRecognizer(tapRecognizer!)
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "VideoCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VideoCell
        
        // Fetches the appropriate video for the data source layout.
        
        let video : Video?
        
    
        if(searchActive){
            
            video = filtered[(indexPath as NSIndexPath).row]
            
            
            
            // cell.textLabel?.text = filtered[indexPath.row]
            
        } else {
            
            //  video = myVideos[(indexPath as NSIndexPath).row] to fix delete error
            
            video = filtered[(indexPath as NSIndexPath).row]
            
            
        }
        
        
        cell.delegate = self
        
        cell.titleLabel.text = video!.title
        
        cell.thumbnailView.image = video!.thumbnail
        
        var showDownloadControls = false
        
        if let download = GlobalVariables.sharedManager.activeDownloads[video!.sourceUrl!] {
            
            showDownloadControls = true
            
            cell.progressView.progress = download.progress
            
            //cell.progressLabel.text = (download.isDownloading) ? "Downloading..." : "Paused"
            
            let title = (download.isDownloading) ? "Pause" : "Resume"
            
            cell.pauseButton.setTitle(title, for: UIControlState())
            
        }
        
        cell.progressView.isHidden = !showDownloadControls
        
        // cell.progressLabel.hidden = !showDownloadControls
        
        // If the track is already downloaded, enable cell selection and hide the Download button
        
        let downloaded = localFileExistsForVideo(video!)
        
        cell.selectionStyle = downloaded ? UITableViewCellSelectionStyle.gray : UITableViewCellSelectionStyle.none
        
        cell.downloadButton.isHidden = downloaded || showDownloadControls
        
        cell.pauseButton.isHidden = !showDownloadControls
        
        cell.cancelButton.isHidden = !showDownloadControls
        
        return cell
        
    }
    
    

    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {  //double check this override
        
        searchActive = false
        
        searchBar.resignFirstResponder()
    }
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.characters.count == 0) {
            
            self.parent!.view.addGestureRecognizer(tapRecognizer!)
            
            searchExamplesView!.isHidden = true
            
            myVideoEmptyLabel?.isHidden = false
            
            self.tableView.isHidden = true
            
            //  searchBar.resignFirstResponder()
            
        } else {
            
            //    self.parent!.view.removeGestureRecognizer(tapRecognizer!)    changed withoput testing in order to have searchtext with letter in myvideos still dismiss
            
            self.tableView.isHidden = false
            
            myVideoEmptyLabel?.isHidden = true
            
            searchExamplesView!.isHidden = true
            
        }
        
        filtered = myVideos.filter({ (text) -> Bool in
            
            let tmp: NSString = text.title! as NSString
            
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            
            return range.location != NSNotFound
            
        })
        
        if(filtered.count == 0){
            
            tableView.isHidden = true
            
            searchActive = true  //true results in table only appearing when search is active (only after initial search is made)
            
        } else {
            
            searchActive = true
            
        }
        
        self.tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            
            let videoDetailViewController = segue.destination as! VideoViewController
            
            // Get the cell that generated this segue.
            
            if let selectedVideoCell = sender as? VideoCell {
                
                let indexPath = tableView.indexPath(for: selectedVideoCell)!
                
                var count = 0  //code to map filtered result position to searchResult position
                
                for result in searchResults {
                    
                    if (filtered[(indexPath as NSIndexPath).row].title == result.title) {
                        
                        let selectedVideo = searchResults[count]
                        
                        videoDetailViewController.video = selectedVideo
                        
                        videoDetailViewController.setDefaultSession(defaultSession: &defaultSession)
                        
                        videoDetailViewController.setDataTask(dataTask: &dataTask)
                        
                        
                        videoDetailViewController.setDownloadsSession(downloadsSession: &downloadsSession)
                        
                        
                        //    videoDetailViewController.activeDownloads = activeDownloads
  
                        
                    }
                    
                    count += 1
                    
                }
                
            }
            
        }
            
        else if segue.identifier == "AddItem" {
            
            print("Adding new video.")
            
        }
        
    }
    
    // MARK: - Table view data source
    
    
    // Override to support conditional editing of the table view.
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            
            return filtered.count
            
        }
        
        return filtered.count   //use data.count to always display intial table of all searchResults
        
    }
    
    // Override to support editing the table view.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // Changed from videos.remove to filtered. This stops the crash but the videos reappear when a new search is started
            
            
            if(myVideos.contains(filtered[(indexPath as NSIndexPath).row])) {
                
                
                let video = myVideos.index(of: filtered[(indexPath as NSIndexPath).row])
                
                
                deleteVideo(filtered[(indexPath as NSIndexPath).row])
                
                myVideos.remove(at: video!)
                
                
                
            }
            
            filtered.remove(at: (indexPath as NSIndexPath).row)
            
            
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
            // Delete the row from the data source
            
            saveVideos()
            
            
            
            
            
            // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
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
    
    /*
     
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     if segue.identifier == "ShowDetails" {
     
     let videoDetailViewController = segue.destinationViewController as! SearchDetailViewController
     
     // Get the cell that generated this segue.
     if let selectedVideoCell = sender {
     
     let indexPath = tableView.indexPathForCell(selectedVideoCell as! UITableViewCell)!
     
     var count = 0  //code to map filtered result position to searchResult position
     
     for result in searchResults {
     
     if (filtered[indexPath.row] == result.title) {
     
     let selectedVideo = searchResults[count]
     
     videoDetailViewController.video = selectedVideo
     
     }
     
     count += 1
     }
     
     }
     
     }
     
     }
     
     */
    
    @IBAction override func unwindToVideoList(_ sender: UIStoryboardSegue) {
        
  
        
        if let sourceViewController = sender.source as? VideoViewController, let video = sourceViewController.video {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing video.
                
                print("updating from unwind")
                
                //  videos[selectedIndexPath.row] = video
                
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                
                // Add a new video.
              
                
                if(!myVideos.contains(video)) {
                    let newIndexPath = IndexPath(row: filtered.count, section: 0)
                    
                    
                    filtered.append(video)
                    myVideos.append(video)
                    
                    self.tableView.insertRows(at: [newIndexPath], with: .bottom)
                    
                }
            }
            // Save the videos.
            var parentVC = parent as? SearchViewController
            
            parentVC?.setMyVideoView()
            
            
            
            saveVideos()
            
            
            
        }
        
    }
    
    override func videoIndexForDownloadTask(_ downloadTask: URLSessionDownloadTask) -> Int? {
        
        if let url = downloadTask.originalRequest?.url?.absoluteString {
            
            for (index, video) in filtered.enumerated() {
                
                if url == video.sourceUrl! {
                    
                    return index
                    
                }
                
            }
            
        }
        
        return nil
        
    }
    
}

