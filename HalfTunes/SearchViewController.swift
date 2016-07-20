//
//  SearchViewController.swift
//  HalfTunes
//
//  Created by Ken Toh on 13/7/15.
//  Copyright (c) 2015 Ken Toh. All rights reserved.
//

import UIKit
import MediaPlayer

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var activeDownloads = [String: Download]()
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    var dataTask: NSURLSessionDataTask?
    
    var searchResults = [Video]()
    

    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(SearchViewController.dismissKeyboard))
        return recognizer
    }()
    
    lazy var downloadsSession: NSURLSession = {
        let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("bgSessionConfiguration")
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        return session
    }()
    
    // MARK: View controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        _ = self.downloadsSession
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Handling Search Results
    
    // This helper method helps parse response JSON NSData into an array of Track objects.
    func updateSearchResults(data: NSData?) {
        searchResults.removeAll()
        
        
        
        
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
        
        guard let thumbnail = Videos.thumbnail else {
            
            return
            
        }

        
       //MARK: May not work
        
        searchResults.append(Video(title: show.title, thumbnail: UIImage(contentsOfFile: thumbnail.thumbnail), fileName: vod.fileName, sourceUrl: vod.url)!)
        
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
            self.tableView.setContentOffset(CGPointZero, animated: false)
        }
    }
    
    
    
    
    
    
    // MARK: Keyboard dismissal
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
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
         for (index, video) in searchResults.enumerate() {
         if url == video.sourceUrl! {
         return index
         }
         }
         }
         
        
        return nil
    }
}

// MARK: - NSURLSessionDelegate

extension SearchViewController: NSURLSessionDelegate {
    
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

extension SearchViewController: NSURLSessionDownloadDelegate {
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
                    videoCell.progressLabel.text =  String(format: "%.1f%% of %@",  download.progress * 100, totalSize)
                })
            }
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
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
            // 8
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
}

// MARK: TrackCellDelegate

extension SearchViewController: VideoCellDelegate {
    func pauseTapped(cell: VideoCell) {
        if let indexPath = tableView.indexPathForCell(cell) {
            let video = searchResults[indexPath.row]
            pauseDownload(video)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .None)
        }
    }
    
    func resumeTapped(cell: VideoCell) {
        if let indexPath = tableView.indexPathForCell(cell) {
            let video = searchResults[indexPath.row]
            resumeDownload(video)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .None)
        }
    }
    
    func cancelTapped(cell: VideoCell) {
        if let indexPath = tableView.indexPathForCell(cell) {
            let video = searchResults[indexPath.row]
            cancelDownload(video)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .None)
        }
    }
    
    func downloadTapped(cell: VideoCell) {
        if let indexPath = tableView.indexPathForCell(cell) {
            let video = searchResults[indexPath.row]
            startDownload(video)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .None)
        }
    }
}

// MARK: UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell", forIndexPath: indexPath) as!VideoCell
        
        // Delegate cell button tap events to this view controller
        cell.delegate = self
        
        let video = searchResults[indexPath.row]
        
        // Configure title and artist labels
        cell.titleLabel.text = video.title
        cell.fileNameLabel.text = video.fileName
        
        var showDownloadControls = false
        if let download = activeDownloads[video.sourceUrl!] {
            showDownloadControls = true
            
            cell.progressView.progress = download.progress
            cell.progressLabel.text = (download.isDownloading) ? "Downloading..." : "Paused"
            
            let title = (download.isDownloading) ? "Pause" : "Resume"
            cell.pauseButton.setTitle(title, forState: UIControlState.Normal)
        }
        cell.progressView.hidden = !showDownloadControls
        cell.progressLabel.hidden = !showDownloadControls
        
        // If the track is already downloaded, enable cell selection and hide the Download button
        let downloaded = localFileExistsForVideo(video)
        cell.selectionStyle = downloaded ? UITableViewCellSelectionStyle.Gray : UITableViewCellSelectionStyle.None
        cell.downloadButton.hidden = downloaded || showDownloadControls
        
        cell.pauseButton.hidden = !showDownloadControls
        cell.cancelButton.hidden = !showDownloadControls
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 62.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let video = searchResults[indexPath.row]
        if localFileExistsForVideo(video) {
            playDownload(video)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}





