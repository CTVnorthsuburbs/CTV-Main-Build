//
//  CategoryTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 11/1/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit


import MediaPlayer

class CategoryTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, VideoCellDelegate {
    
    
    
    
    var category: Category = Category.hockey
    
    
    
    
   
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        }
        
        return .none
    }
    



        
        var videos = [Video]()
        
        var searchBar: UISearchBar!
        
        var searchResults = [Video]()          //this holds the list of all videos
        
        var myVideos = [Video]()                //this holds the videos saved to myVideos
        
        var searchActive : Bool = false
        
        //  var data = [Video]()                //videos accesible to search
        
        var filtered:[Video] = []               //videos as they are filtered by the search
        
        var tapRecognizer : UITapGestureRecognizer?
        
        var searchExamplesView : UIView?
        
        var myVideoEmptyLabel : UILabel?
        
        var progressView : UIProgressView? = nil
        
        // var moviePlayer : MPMoviePlayerController?
        
        
        
        
        
        var defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        var dataTask = URLSessionDataTask()
        
        lazy var downloadsSession: Foundation.URLSession = {
            
            let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
            
            let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
            
            return session
            
        }()
        
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
          
                var search = VideoSearch()
                
                self.myVideos = search.getRecent()
                
            
            _ = self.downloadsSession
            //  self.filtered = self.myVideos
            
            
            
        }
        
        
        override func viewWillAppear(_ animated: Bool) {
            
            self.filtered = self.myVideos
            super.viewWillAppear(animated)
            tableView.reloadData()
            
            
            
            for vid in GlobalVariables.sharedManager.activeDownloads {
                
                
                print("active downloads : ")
                print(GlobalVariables.sharedManager.activeDownloads)
            }
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        func didTapView(){
            
            self.parent!.view.endEditing(true)
            self.view.removeGestureRecognizer(tapRecognizer!)
            
            self.parent!.view.removeGestureRecognizer(tapRecognizer!)
            
            
        }
        
        override func awakeFromNib() {
            tableView.reloadData()
            
        }
        
        
        
        func playVideo(_ video: Video) {
            
            //Get the Video Path
            print("playing video\(video.title)")
            let videoPath = Bundle.main.path(forResource: video.sourceUrl, ofType:"mp4")
            print("path\(videoPath)")
            //Make a URL from your path
            print("source url \(video.sourceUrl)")
            //Initalize the movie player
            
            if (!localFileExistsForVideo(video)) {
                
                if let urlString = video.sourceUrl, let url = localFilePathForUrl(urlString) {
                    print("url string \(urlString)")
                    let fileUrl = URL(string: urlString)
                    
                    
                    print("fileurl \(fileUrl)")
                    
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
            
            cell.dateLabel.text = convertDateToString(date: video!.eventDate!)
            
            cell.thumbnailView.image = video!.thumbnail
            
            
            cell.thumbnailView.setRadius(radius: 4)
            
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
        
        
        
        
        
        
        
        func pauseTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                pauseDownload(video)
                
                tableView.reloadRows(at: [IndexPath(row: (indexPath as NSIndexPath).row, section: 0)], with: .none)
                
            }
            
        }
        
        func resumeTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                resumeDownload(video)
                
                tableView.reloadRows(at: [IndexPath(row: (indexPath as NSIndexPath).row, section: 0)], with: .none)
                
            }
            
        }
        
        func cancelTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                cancelDownload(video)
                
                tableView.reloadRows(at: [IndexPath(row: (indexPath as NSIndexPath).row, section: 0)], with: .none)
                
            }
            
        }
        
        func downloadTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                startDownload(video)
                
                tableView.reloadRows(at: [IndexPath(row: (indexPath as NSIndexPath).row, section: 0)], with: .none)
                
            }
        }
        
        func thumbnailTapped(_ cell: VideoCell) {
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let video = filtered[(indexPath as NSIndexPath).row]
                
                playVideo(video)
                
            }
            
        }
        
        
        
        
        
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            
            searchActive = true
            
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            
            searchActive = false
            
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            searchActive = false
            
            
            
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            searchActive = false
            
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            if (searchText.characters.count == 0) {
                
                
                
                self.tableView.isHidden = true
                
            } else {
                
                self.tableView.isHidden = false
                
                
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
                    
                    
                    let selectedVideo = myVideos[indexPath.row]
                    
                    videoDetailViewController.video = selectedVideo
                    
                    //    videoDetailViewController.setActiveDownloads(downloads: &activeDownloads)
                    
                    
                    videoDetailViewController.setDefaultSession(defaultSession: &defaultSession)
                    
                    videoDetailViewController.setDataTask(dataTask: &dataTask)
                    
                    
                    videoDetailViewController.setDownloadsSession(downloadsSession: &downloadsSession)
                    
                }
                
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
                
                
                
                GlobalVariables.sharedManager.activeDownloads[video.sourceUrl!] = nil
                
                
                
                
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                
                
                // Delete the row from the data source
                
                saveVideos()
                
                
                // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            } else if editingStyle == .insert {
                
                
                print("insert runs")
                
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
        
        @IBAction  func unwindToVideoList(_ sender: UIStoryboardSegue) {
            
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
        
        func saveVideos() {
            
            
            
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.myVideos, toFile: Video.ArchiveURL.path)
            
            
            
            
            if !isSuccessfulSave {
                
                print("Failed to save videos...")
                
            }
            
        }
        
        func loadVideos() -> [Video]? {
            
            var loaded = NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
            
            return  loaded
            
        }
        
        
        
        // Called when the Download button for a track is tapped
        
        func startDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl, let url =  URL(string: urlString) {
                
                let download = Download(url: urlString)
                
                download.downloadTask = downloadsSession.downloadTask(with: url)
                
                download.downloadTask!.resume()
                
                download.isDownloading = true
                
                GlobalVariables.sharedManager.activeDownloads[download.url] = download
                
            }
        }
        
        // Called when the Pause button for a track is tapped
        
        func pauseDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl,
                
                let download = GlobalVariables.sharedManager.activeDownloads[urlString] {
                
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
        
        func cancelDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl,
                
                let download = GlobalVariables.sharedManager.activeDownloads[urlString] {
                
                download.downloadTask?.cancel()
                
                GlobalVariables.sharedManager.activeDownloads[urlString] = nil
                
            }
            
        }
        
        // Called when the Resume button for a track is tapped
        
        func resumeDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl,
                
                let download = GlobalVariables.sharedManager.activeDownloads[urlString] {
                
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
        
        func playDownload(_ video: Video) {
            
            if let urlString = video.sourceUrl, let url = localFilePathForUrl(urlString) {
                
                let moviePlayer:MPMoviePlayerViewController! = MPMoviePlayerViewController(contentURL: url)
                
                presentMoviePlayerViewControllerAnimated(moviePlayer)
            }
            
        }
        
        // MARK: Download helper methods
        
        // This method generates a permanent local file path to save a track to by appending
        // the lastPathComponent of the URL (i.e. the file name and extension of the file)
        // to the path of the app’s Documents directory.
        
        func localFilePathForUrl(_ previewUrl: String) -> URL? {
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            
            let url = URL(string: previewUrl)
            
            
            let lastPathComponent = url?.lastPathComponent
            
            let fullPath = documentsPath.appendingPathComponent(lastPathComponent!)
            
            return URL(fileURLWithPath:fullPath)
            
            
            
            //return nil
            
        }
        
        // This method checks if the local file exists at the path generated by localFilePathForUrl(_:)
        
        func localFileExistsForVideo(_ video: Video) -> Bool {
            
            if let urlString = video.sourceUrl, let localUrl = localFilePathForUrl(urlString) {
                
                var isDir : ObjCBool = false
                
                let path = localUrl.path
                
                return FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
                
                
                
            }
            
            return false
            
        }
        
        
        func deleteVideo(_ video: Video)  {
            
            if let urlString = video.sourceUrl, let localUrl = localFilePathForUrl(urlString) {
                
                
                print("localurl:\(localUrl)")
                var isDir : ObjCBool = false
                
                let path = localUrl.path
                
                do { try FileManager.default.removeItem(atPath: path)
                    
                    print("deleted")
                    
                } catch {
                    
                    
                    print("cant delete")
                }
                
            }
            
            
            
        }
        
        
        func videoIndexForDownloadTask(_ downloadTask: URLSessionDownloadTask) -> Int? {
            
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


    
    // MARK: - NSURLSessionDelegate
    
    extension CategoryTableViewController: URLSessionDelegate {
        
        func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                
                if let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                    
                    appDelegate.backgroundSessionCompletionHandler = nil
                    
                    DispatchQueue.main.async(execute: {
                        
                        completionHandler()
                        
                    })
                }
            }
        }
    }
    
    // MARK: - NSURLSessionDownloadDelegate
    
    extension CategoryTableViewController: URLSessionDownloadDelegate {
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            
            if let originalURL = downloadTask.originalRequest?.url?.absoluteString,
                
                let destinationURL = localFilePathForUrl(originalURL) {
                
                print(destinationURL)
                
                let fileManager = FileManager.default
                
                do {
                    
                    try fileManager.removeItem(at: destinationURL)
                    
                } catch {
                    
                    // Non-fatal: file probably doesn't exist
                    
                }
                
                do {
                    
                    try fileManager.copyItem(at: location, to: destinationURL)
                    
                } catch let error as NSError {
                    
                    print("Could not copy file to disk: \(error.localizedDescription)")
                    
                }
                
            }
            
            if let url = downloadTask.originalRequest?.url?.absoluteString {
                
                GlobalVariables.sharedManager.activeDownloads[url] = nil
                
                if let videoIndex = videoIndexForDownloadTask(downloadTask) {
                    
                    DispatchQueue.main.async(execute: {
                        
                        self.tableView.reloadRows(at: [IndexPath(row: videoIndex, section: 0)], with: .none)
                        
                    })
                    
                }
                
            }
            
        }
        
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
            
            if let downloadUrl = downloadTask.originalRequest?.url?.absoluteString,
                
                let download = GlobalVariables.sharedManager.activeDownloads[downloadUrl] {
                // 2
                
                download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
                // 3
                let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: ByteCountFormatter.CountStyle.binary)
                // 4
                
                
                
                if let videoIndex = videoIndexForDownloadTask(downloadTask), let videoCell = tableView.cellForRow(at: IndexPath(row: videoIndex, section: 0)) as? VideoCell {
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        
                        videoCell.progressView.progress = download.progress
                        
                        var temp =  GlobalVariables.sharedManager.getDownload(downloadUrl: downloadUrl)
                        
                        temp?.progress = download.progress
                        
                        
                        
                        
                        
                    })
                    
                }
                
            }
            
        }
        
}


