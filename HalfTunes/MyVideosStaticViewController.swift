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

class MyVideosStaticViewController: MyVideosViewController {
    
    
    
    
    override func viewDidLoad() {
        
  
        
       
        super.viewDidLoad()
        
        self.myVideos = loadVideos()!
        
        self.filtered = self.myVideos
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
             myVideos = loadVideos()!
         self.filtered = self.myVideos
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
 
        
        
        override func playVideo(_ video: Video) {
            
            //Get the Video Path
            
            let videoPath = Bundle.main.path(forResource: video.sourceUrl, ofType:"mp4")
            
            //Make a URL from your path
            
            //Initalize the movie player
            
            if (!localFileExistsForVideo(video)) {
                
                if let urlString = video.sourceUrl, let url = localFilePathForUrl(urlString) {
                    
                    let fileUrl = URL(string: urlString)
                    
                    let moviePlayer:MPMoviePlayerViewController! = MPMoviePlayerViewController(contentURL: fileUrl)
                    
                    presentMoviePlayerViewControllerAnimated(moviePlayer)
                    
                }
                
            } else {
                print("local file exists for: \(video.title)")
                playDownload(video)
                
            }
            
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // Table view cells are reused and should be dequeued using a cell identifier.
            
            let cellIdentifier = "VideoCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VideoCell
            
            // Fetches the appropriate video for the data source layout.
            
            let video : Video?
            
         
  
                video = myVideos[(indexPath as NSIndexPath).row]
                
                
                
            
            
            
            
            cell.delegate = self
            
            cell.titleLabel.text = video!.title
            
            cell.thumbnailView.image = video!.thumbnail
            
            var showDownloadControls = false
            
            if let download = activeDownloads[video!.sourceUrl!] {
                
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
        
        override func pauseTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                pauseDownload(video)
                
                tableView.reloadRows(at: [IndexPath(row: (indexPath as NSIndexPath).row, section: 0)], with: .none)
                
            }
            
        }
        
        override func resumeTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                resumeDownload(video)
                
                tableView.reloadRows(at: [IndexPath(row: (indexPath as NSIndexPath).row, section: 0)], with: .none)
                
            }
            
        }
        
        override func cancelTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                cancelDownload(video)
                
                tableView.reloadRows(at: [IndexPath(row: (indexPath as NSIndexPath).row, section: 0)], with: .none)
                
            }
            
        }
        
        override func downloadTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                startDownload(video)
                
                tableView.reloadRows(at: [IndexPath(row: (indexPath as NSIndexPath).row, section: 0)], with: .none)
                
            }
        }
        
        override func thumbnailTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                playVideo(video)
                
            }
            
        }
        
        override func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            
            searchActive = true
            
        }
        
        override func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            
            searchActive = false
            
        }
        
        override func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            searchActive = false
            
            
            
        }
        
        override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            searchActive = false
            
        }
        
        override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            if (searchText.characters.count == 0) {
                
                searchExamples!.isHidden = false
                
                searchExampleTitle!.isHidden = false
                
                self.tableView.isHidden = true
                
            } else {
                
                self.tableView.isHidden = false
                
                searchExamples!.isHidden = true
                
                searchExampleTitle!.isHidden = true
                
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
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            
            return 1
            
        }
        
        // Override to support conditional editing of the table view.
        
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            
            // Return false if you do not want the specified item to be editable.
            
            return true
        }
        
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if(searchActive) {
                
                return myVideos.count
                
            }
            
            return myVideos.count   //use data.count to always display intial table of all searchResults
            
        }
        
        // Override to support editing the table view.
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                
                // Changed from videos.remove to filtered. This stops the crash but the videos reappear when a new search is started
                
                
           
                    
                    
                    let video = myVideos[indexPath.row]
                    
                    
                    deleteVideo(video)
                    
                myVideos.remove(at: indexPath.row)
                    
                
                    
                
                
             
                
                print("after delete")
                printVideos(video: myVideos)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                
                
                // Delete the row from the data source
                
                saveVideos()
                
                
                print("printing myvideos")
                
                printVideos(video: myVideos)
                
                // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            } else if editingStyle == .insert {
                
                
                print("insert runs")
                
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
                
            }
            
        }
        
        
        override func printVideos(video: [Video]) {
            
            print("Printing array")
            for vid in video {
                
                print(vid.title)
                
                
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
                        let newIndexPath = IndexPath(row: myVideos.count, section: 0)
                        
                        
                        
                        //filtered.append(video)
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
        
        // MARK: NSCoding
        
        override func saveVideos() {
            
            
            
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(myVideos, toFile: Video.ArchiveURL.path)
            
            
            
            
            if !isSuccessfulSave {
                
                print("Failed to save videos...")
                
            }
            
        }
        
        override func loadVideos() -> [Video]? {
            
            return NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
        }
        
   
        
        // Called when the Download button for a track is tapped
        
        override func startDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl, let url =  URL(string: urlString) {
                
                let download = Download(url: urlString)
                
                download.downloadTask = downloadsSession.downloadTask(with: url)
                
                download.downloadTask!.resume()
                
                download.isDownloading = true
                
                activeDownloads[download.url] = download
                
            }
        }
        
        // Called when the Pause button for a track is tapped
        
        override func pauseDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl,
                
                let download = activeDownloads[urlString] {
                
                if(download.isDownloading) {
                    
                    download.downloadTask?.cancel { data in
                        
                        if data != nil {
                            
                            download.resumeData = correctResumeData(data)
                            
                            
                        }
                    }
                    
                    download.isDownloading = false
                    
                }
                
            }
            
        }
        
        // Called when the Cancel button for a track is tapped
        
        override func cancelDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl,
                
                let download = activeDownloads[urlString] {
                
                download.downloadTask?.cancel()
                
                activeDownloads[urlString] = nil
                
            }
            
        }
        
        // Called when the Resume button for a track is tapped
        
        override func resumeDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl,
                
                let download = activeDownloads[urlString] {
                
                if let resumeData = download.resumeData {
                    
                    download.downloadTask = downloadsSession.correctedDownloadTask(withResumeData: resumeData)
                    
                    download.downloadTask!.resume()
                    
                    download.isDownloading = true
                    
                } else if let url = URL(string: download.url) {
                    
                    download.downloadTask = downloadsSession.downloadTask(with: url)
                    
                    download.downloadTask!.resume()
                    
                    download.isDownloading = true
                    
                }
                
            }
            
        }
        
        // This method attempts to play the local file (if it exists) when the cell is tapped
        
        override func playDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl, let url = localFilePathForUrl(urlString) {
                
                let moviePlayer:MPMoviePlayerViewController! = MPMoviePlayerViewController(contentURL: url)
                
                presentMoviePlayerViewControllerAnimated(moviePlayer)
            }
            
        }
        
        // MARK: Download helper methods
        
        // This method generates a permanent local file path to save a track to by appending
        // the lastPathComponent of the URL (i.e. the file name and extension of the file)
        // to the path of the app’s Documents directory.
        
        override func localFilePathForUrl(_ previewUrl: String) -> URL? {
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            
            let url = URL(string: previewUrl)
            
            
            let lastPathComponent = url?.lastPathComponent
            
            let fullPath = documentsPath.appendingPathComponent(lastPathComponent!)
            
            return URL(fileURLWithPath:fullPath)
            
            
            
            //return nil
            
        }
        
        // This method checks if the local file exists at the path generated by localFilePathForUrl(_:)
        
        override func localFileExistsForVideo(_ video: Video) -> Bool {
            
            if let urlString = video.sourceUrl, let localUrl = localFilePathForUrl(urlString) {
                
                var isDir : ObjCBool = false
                
                let path = localUrl.path
                
                return FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
                
                
                
            }
            
            return false
            
        }
        
        
        override func deleteVideo(_ video: Video)  {
            
            if let urlString = video.sourceUrl, let localUrl = localFilePathForUrl(urlString) {
                
                var isDir : ObjCBool = false
                
                let path = localUrl.path
                
                do { try FileManager.default.removeItem(atPath: path)
                    
                    print("deleted")
                    
                } catch {
                    
                    
                    print("cant delete")
                }
                
            }
            
            
            
        }
        
        
        override func videoIndexForDownloadTask(_ downloadTask: URLSessionDownloadTask) -> Int? {
            
            if let url = downloadTask.originalRequest?.url?.absoluteString {
                
                for (index, video) in myVideos.enumerated() {
                    
                    if url == video.sourceUrl! {
                        
                        return index
                        
                    }
                    
                }
                
            }
            
            return nil
            
        }
        
    }
    
 
