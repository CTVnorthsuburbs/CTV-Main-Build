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



class VideoTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, VideoCellDelegate {
    
    
    
    
  
    
    
    // MARK: Properties
    
    var videos = [Video]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved videos, otherwise load sample data.
        if let savedVideos = loadVideos() {
            videos += savedVideos
        } else {
            // Load the sample data.
            //loadSampleVideos()
        }

        tableView.tableFooterView = UIView()
        _ = self.downloadsSession
        
        
        super.viewDidLoad()
        
    }
    
    
    // MARK: Handling Search Results
    
    // This helper method helps parse response JSON NSData into an array of Track objects.
    func updateSearchResults(data: NSData?) {
        searchResults.removeAll()
        
        
        var tempThumb : UIImage = UIImage(named: "meal1")!
        
        var json: [String: AnyObject]!
        
        
        do {
            
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
            
        } catch {
            
            print(error)
            
        }
        
        guard let Videos = Videos(json: json) else {
            
            return
            
    }
        
        guard let show = Videos.show else {
            
            return
            
        }
        
        guard let vod = Videos.vod!.first else {
            
            return
            
        }
        
        guard let thumbnail = Videos.thumbnail!.first else {
            
            return
        }
        
    
        //MARK: May not work
        
  /* use thumbnail files from trms
        
        if let url = NSURL(string: thumbnail.url) {
            if let data = NSData(contentsOfURL: url) {
                tempThumb = UIImage(data: data)!
            }        
        }
        
        
   */
        
        do {
            let asset = AVURLAsset(URL: NSURL(string: vod.url)!, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImageAtTime(CMTimeMake(30, 1), actualTime: nil)
            tempThumb = UIImage(CGImage: cgImage)
           
            // lay out this image view, or if it already exists, set its image property to uiImage
        } catch let error as NSError {
            print("Error generating thumbnail: \(error)")
        }
        
        
        
        searchResults.append(Video(title: show.title, thumbnail: tempThumb, fileName: vod.fileName, sourceUrl: vod.url)!)
        
        
        //this is to test but needs to be removed
        
        videos.append(Video(title: show.title, thumbnail: tempThumb, fileName: vod.fileName, sourceUrl: vod.url)!)
        
        
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
            //self.tableView.setContentOffset(CGPointZero, animated: false)    this closes the searchbar but is broken
        }
    }
    
    
    
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
    
    
    // MARK: Keyboard dismissal
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {

        dismissKeyboard()
        
        if !searchBar.text!.isEmpty {
            // 1
            if dataTask != nil {
                dataTask?.cancel()
            }
            // 2
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            // 3
            let expectedCharSet = NSCharacterSet.URLQueryAllowedCharacterSet()
            let searchTerm = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet)!
            // 4
            let url = NSURL(string: "http://trms.ctv15.org/cablecastapi/v1/shows/\(searchTerm)?include=vod,thumbnail")
            // 5
            dataTask = defaultSession.dataTaskWithURL(url!) {
                data, response, error in
                // 6
                dispatch_async(dispatch_get_main_queue()) {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
                // 7
                if let error = error {
                    print(error.localizedDescription)
                    
                
                } else if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        
                        
       
                        self.updateSearchResults(data)
             
                        
                        
                    }
                }
            }
           
            dataTask?.resume()
            
           
        }
  
        
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
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

extension VideoTableViewController: NSURLSessionDelegate {
    
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

extension VideoTableViewController: NSURLSessionDownloadDelegate {
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

