//
//  MyVideosResultsControllerView.swift
//  HalfTunes
//
//  Created by William Ogura on 8/31/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation


//
//  VideoTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit


import MediaPlayer



class MyVideosResultsControllerView: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, VideoCellDelegate {
    
    
    
    
    
    
    
    
    // MARK: Properties
    
   // var videos = [Video]()
    
    
    
    var videos = getSampleVideos()

    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
   
        

   
                _ = self.downloadsSession
        
        
        super.viewDidLoad()
        
    }
    
    
    // MARK: Handling Search Results

    
    var moviePlayer : MPMoviePlayerController?
    
    
    func playVideo(video: Video) {
        
        //Get the Video Path
        //You need to put this in Project->Target->copy bundle resource for this to work
        let videoPath = NSBundle.mainBundle().pathForResource(video.sourceUrl, ofType:"mp4")
        
        //Make a URL from your path
        //let url = NSURL.fileURLWithPath(videoPath!)
        
        //Initalize the movie player
        
        
        
        if (!localFileExistsForVideo(video)) {
            if let urlString = video.sourceUrl, url = localFilePathForUrl(urlString) {
                
                
                
                let fileUrl = NSURL(string: urlString)
                
                let moviePlayer:MPMoviePlayerViewController! = MPMoviePlayerViewController(contentURL: fileUrl)
                presentMoviePlayerViewControllerAnimated(moviePlayer)
            }
            
        } else {
            
            playDownload(video)
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
        
        
        
        
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "VideoCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! VideoCell
        
        // Fetches the appropriate video for the data source layout.
        let video = videos[indexPath.row]
        
        
        
        cell.delegate = self
        
        
        cell.titleLabel.text = video.title
        cell.thumbnailView.image = video.thumbnail
        
        
        
        
        
        
        var showDownloadControls = false
        
        
        
        if let download = activeDownloads[video.sourceUrl!] {
            
            
            
            
            showDownloadControls = true
            
            cell.progressView.progress = download.progress
            //cell.progressLabel.text = (download.isDownloading) ? "Downloading..." : "Paused"
            
            let title = (download.isDownloading) ? "Pause" : "Resume"
            cell.pauseButton.setTitle(title, forState: UIControlState.Normal)
        }
        
        
        
        
        cell.progressView.hidden = !showDownloadControls
        // cell.progressLabel.hidden = !showDownloadControls
        
        // If the track is already downloaded, enable cell selection and hide the Download button
        let downloaded = localFileExistsForVideo(video)
        cell.selectionStyle = downloaded ? UITableViewCellSelectionStyle.Gray : UITableViewCellSelectionStyle.None
        cell.downloadButton.hidden = downloaded || showDownloadControls
        
        cell.pauseButton.hidden = !showDownloadControls
        cell.cancelButton.hidden = !showDownloadControls
        
        
        
        
        
        
        
        
        return cell
    }
    
    
    
    
    
    
    
    func pauseTapped(cell: VideoCell) {
        if let indexPath = tableView.indexPathForCell(cell) {
            let video = videos[indexPath.row]
            pauseDownload(video)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .None)
        }
    }
    
    func resumeTapped(cell: VideoCell) {
        if let indexPath = tableView.indexPathForCell(cell) {
            let video = videos[indexPath.row]
            resumeDownload(video)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .None)
        }
    }
    
    func cancelTapped(cell: VideoCell) {
        if let indexPath = tableView.indexPathForCell(cell) {
            let video = videos[indexPath.row]
            cancelDownload(video)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .None)
        }
    }
    
    func downloadTapped(cell: VideoCell) {
        
        
        
        if let indexPath = tableView.indexPathForCell(cell) {
            let video = videos[indexPath.row]
            startDownload(video)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .None)
            
            
        }
    }
    
    
    func thumbnailTapped(cell: VideoCell) {
        
        if let indexPath = tableView.indexPathForCell(cell) {
            let video = videos[indexPath.row]
            playVideo(video)
            
        }
        
    }
    
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
            let videoDetailViewController = segue.destinationViewController as! VideoViewController
            
            // Get the cell that generated this segue.
            if let selectedVideoCell = sender as? VideoCell {
                let indexPath = tableView.indexPathForCell(selectedVideoCell)!
                let selectedVideo = videos[indexPath.row]
                videoDetailViewController.video = selectedVideo
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new video.")
            
        }
    }
    
    
    
    
    
    @IBAction func unwindToVideoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? VideoViewController, video = sourceViewController.video {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing video.
                videos[selectedIndexPath.row] = video
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new video.
                let newIndexPath = NSIndexPath(forRow: videos.count, inSection: 0)
                videos.append(video)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the videos.
            saveVideos()
        }
    }
    
    // MARK: NSCoding
    
    func saveVideos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(videos, toFile: Video.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save videos...")
        }
    }
    
    func loadVideos() -> [Video]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Video.ArchiveURL.path!) as? [Video]
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var activeDownloads = [String: Download]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    var dataTask: NSURLSessionDataTask?
    
    var searchResults = [Video]()
    
    
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(VideoTableViewController.dismissKeyboard))
        return recognizer
    }()
    
    lazy var downloadsSession: NSURLSession = {
        let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("bgSessionConfiguration")
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        return session
    }()
    
    // MARK: View controller methods
    
    
    
    
    
    // MARK: Download methods
    
    // Called when the Download button for a track is tapped
    func startDownload(video: Video) {
        
        
        if let urlString = video.sourceUrl, url =  NSURL(string: urlString) {
            // 1
            let download = Download(url: urlString)
            // 2
            download.downloadTask = downloadsSession.downloadTaskWithURL(url)
            // 3
            download.downloadTask!.resume()
            // 4
            download.isDownloading = true
            // 5
            activeDownloads[download.url] = download
        }
    }
    
    // Called when the Pause button for a track is tapped
    func pauseDownload(video: Video) {
        if let urlString = video.sourceUrl,
            download = activeDownloads[urlString] {
            if(download.isDownloading) {
                download.downloadTask?.cancelByProducingResumeData { data in
                    if data != nil {
                        download.resumeData = data
                    }
                }
                download.isDownloading = false
            }
        }
    }
    
    // Called when the Cancel button for a track is tapped
    func cancelDownload(video: Video) {
        if let urlString = video.sourceUrl,
            download = activeDownloads[urlString] {
            download.downloadTask?.cancel()
            activeDownloads[urlString] = nil
        }
    }
    
    // Called when the Resume button for a track is tapped
    func resumeDownload(video: Video) {
        if let urlString = video.sourceUrl,
            download = activeDownloads[urlString] {
            if let resumeData = download.resumeData {
                download.downloadTask = downloadsSession.downloadTaskWithResumeData(resumeData)
                download.downloadTask!.resume()
                download.isDownloading = true
            } else if let url = NSURL(string: download.url) {
                download.downloadTask = downloadsSession.downloadTaskWithURL(url)
                download.downloadTask!.resume()
                download.isDownloading = true
            }
        }
    }
    
    // This method attempts to play the local file (if it exists) when the cell is tapped
    func playDownload(video: Video) {
        if let urlString = video.sourceUrl, url = localFilePathForUrl(urlString) {
            let moviePlayer:MPMoviePlayerViewController! = MPMoviePlayerViewController(contentURL: url)
            presentMoviePlayerViewControllerAnimated(moviePlayer)
        }
    }
    
    // MARK: Download helper methods
    
    // This method generates a permanent local file path to save a track to by appending
    // the lastPathComponent of the URL (i.e. the file name and extension of the file)
    // to the path of the app’s Documents directory.
    func localFilePathForUrl(previewUrl: String) -> NSURL? {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        if let url = NSURL(string: previewUrl), lastPathComponent = url.lastPathComponent {
            let fullPath = documentsPath.stringByAppendingPathComponent(lastPathComponent)
            return NSURL(fileURLWithPath:fullPath)
        }
        return nil
    }
    
    // This method checks if the local file exists at the path generated by localFilePathForUrl(_:)
    func localFileExistsForVideo(video: Video) -> Bool {
        if let urlString = video.sourceUrl, localUrl = localFilePathForUrl(urlString) {
            var isDir : ObjCBool = false
            if let path = localUrl.path {
                return NSFileManager.defaultManager().fileExistsAtPath(path, isDirectory: &isDir)
            }
        }
        return false
    }
    
    func videoIndexForDownloadTask(downloadTask: NSURLSessionDownloadTask) -> Int? {
        
        if let url = downloadTask.originalRequest?.URL?.absoluteString {
            for (index, video) in videos.enumerate() {
                if url == video.sourceUrl! {
                    return index
                }
            }
        }
        
        
        return nil
    }
}

// MARK: - NSURLSessionDelegate

extension MyVideosResultsControllerView: NSURLSessionDelegate {
    
    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            if let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler()
                })
            }
        }
    }
}

// MARK: - NSURLSessionDownloadDelegate

extension MyVideosResultsControllerView: NSURLSessionDownloadDelegate {
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        // 1
        if let originalURL = downloadTask.originalRequest?.URL?.absoluteString,
            destinationURL = localFilePathForUrl(originalURL) {
            
            print(destinationURL)
            
            // 2
            let fileManager = NSFileManager.defaultManager()
            do {
                try fileManager.removeItemAtURL(destinationURL)
            } catch {
                // Non-fatal: file probably doesn't exist
            }
            do {
                try fileManager.copyItemAtURL(location, toURL: destinationURL)
            } catch let error as NSError {
                print("Could not copy file to disk: \(error.localizedDescription)")
            }
        }
        
        // 3
        if let url = downloadTask.originalRequest?.URL?.absoluteString {
            activeDownloads[url] = nil
            
            
            // 4
            if let videoIndex = videoIndexForDownloadTask(downloadTask) {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: videoIndex, inSection: 0)], withRowAnimation: .None)
                })
            }
        }
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        // 1
        if let downloadUrl = downloadTask.originalRequest?.URL?.absoluteString,
            download = activeDownloads[downloadUrl] {
            // 2
            download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            // 3
            let totalSize = NSByteCountFormatter.stringFromByteCount(totalBytesExpectedToWrite, countStyle: NSByteCountFormatterCountStyle.Binary)
            // 4
            if let videoIndex = videoIndexForDownloadTask(downloadTask), let videoCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: videoIndex, inSection: 0)) as? VideoCell {
                dispatch_async(dispatch_get_main_queue(), {
                    videoCell.progressView.progress = download.progress
                    //videoCell.progressLabel.text =  String(format: "%.1f%% of %@",  download.progress * 100, totalSize)
                })
            }
        }
    }
}
