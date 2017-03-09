//
//  MyVideosViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  
//

import Foundation

import UIKit


import MediaPlayer

/// The MyVideosViewController class contains the controller that handles the My Videos table view within the Search View

class MyVideosSearchViewController: MyVideosViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        myVideos = [Video]()
        
        if(loadVideos() != nil) {
            
            myVideos = (loadVideos())!
            
        }

     //   _ = self.downloadsSession
        
        //tapRecognizer must be instantiated to pass it to parent
        
        tapRecognizer = UITapGestureRecognizer()
        
        tapRecognizer?.addTarget(self, action: Selector("didTapView"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(loadVideos() != nil) {
            
            myVideos = loadVideos()!
            
        }

        super.viewWillAppear(animated)
        
        tableView.reloadData()

    }
    
    override func thumbnailTapped(_ cell: VideoCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            

            var video = filtered[(indexPath as NSIndexPath).row]

            if(searchActive){
                
                video = filtered[(indexPath as NSIndexPath).row]

            } else {
                
                  video = myVideos[(indexPath as NSIndexPath).row]
  
            }

            playVideo(video)
            
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "VideoCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VideoCell
        
        let video : Video?
 
            video = filtered[(indexPath as NSIndexPath).row]

        cell.delegate = self
        
        cell.titleLabel.text = video!.title
        
        cell.dateLabel.text = video!.eventDate!.convertDateToString()
        
        cell.thumbnailView.image = video!.thumbnail
        
         cell.thumbnailView.setRadius(radius: imageRadius)
        
        var showDownloadControls = false
        
        if let download = GlobalVariables.sharedManager.activeDownloads[video!.sourceUrl!] {
            
            showDownloadControls = true
            
            cell.progressView.progress = download.progress

            let title = (download.isDownloading) ? "Pause" : "Resume"
            
            cell.pauseButton.setTitle(title, for: UIControlState())
            
        }
        
        cell.progressView.isHidden = !showDownloadControls

        // If the video is already downloaded, enable cell selection and hide the Download button
        
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
            
            
            LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
            
            
            DispatchQueue.global(qos: .userInitiated).async {

            let videoDetailViewController = segue.destination as! VideoViewController
            
            if let selectedVideoCell = sender as? VideoCell {
                
                let indexPath = self.tableView.indexPath(for: selectedVideoCell)!
                
                var count = 0  //code to map filtered result position to searchResult position
                
                for result in self.searchResults {
                    
                    if (self.filtered[(indexPath as NSIndexPath).row].title == result.title) {
                        
                        let selectedVideo = self.searchResults[count]
                        
                        videoDetailViewController.video = selectedVideo
     
                        if(selectedVideo.fileName == 1) {

                            let sections = Category(categoryFactory: CategoryFactory(factorySettings: teens()))

                            sections.createListing()

                            videoDetailViewController.setCategory(category: sections)
          
                        } else {
                            
                            let sections = Category(categoryFactory: CategoryFactory(factorySettings: home()))
                            
                            sections.createListing()
                            
                            videoDetailViewController.setCategory(category: sections)

                        }
                        
                        videoDetailViewController.setDefaultSession(defaultSession: &self.defaultSession)
                        
                        videoDetailViewController.setDataTask(dataTask: &self.dataTask)
                        
                        videoDetailViewController.setDownloadsSession(downloadsSession: &self.downloadsSession)

                    }
                    
                    count += 1
                    
                }
                
            }
                
                DispatchQueue.main.async( execute: {
                    
                    LoadingOverlay.shared.hideOverlayView()
                    
                })
            }

        }

    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            
            return filtered.count
            
        }
        
        return filtered.count   //use data.count to always display intial table of all searchResults
        
    }

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
            
        }
        
    }
    
    @IBAction override func unwindToVideoList(_ sender: UIStoryboardSegue) {

        if let sourceViewController = sender.source as? VideoViewController, let video = sourceViewController.video {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                

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
            let parentVC = parent as? SearchViewController
            
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

