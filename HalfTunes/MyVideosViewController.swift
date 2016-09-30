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

class MyVideosViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, VideoCellDelegate {
    
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
    
    var moviePlayer : MPMoviePlayerController?
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        myVideos = [Video]()
        
        myVideos = loadVideos()!
        
        _ = self.downloadsSession
        
        
        tapRecognizer = UITapGestureRecognizer()
        
        tapRecognizer?.addTarget(self, action: "didTapView")
        
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        myVideos = loadVideos()!
        
        
      //  self.parent!.view.addGestureRecognizer(tapRecognizer!)
        
        
    }
    
    
    func didTapView(){
        
        self.parent!.view.endEditing(true)
          self.view.removeGestureRecognizer(tapRecognizer!)
        
                 self.parent!.view.removeGestureRecognizer(tapRecognizer!)
        print("didtapview")
        
    }
    
    override func awakeFromNib() {
        tableView.reloadData()
        
    }
    
    
    
    func playVideo(_ video: Video) {
        
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
      
        print("serabar did begin")
        
      //  self.parent!.view.removeGestureRecognizer(tapRecognizer!)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchActive = false
      

 
  //self.parent!.view.removeGestureRecognizer(tapRecognizer!)
        
        print("searchbar textdidendedit")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchActive = false
        
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchActive = false
        
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        
        if (searchText.characters.count == 0) {
            
              print("here it goes")
            
             self.parent!.view.addGestureRecognizer(tapRecognizer!)
           
            searchExamplesView!.isHidden = true
            
            myVideoEmptyLabel?.isHidden = false
            
            self.tableView.isHidden = true
            
            searchBar.resignFirstResponder()
            
        } else {
            
           self.parent!.view.removeGestureRecognizer(tapRecognizer!)
        
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
            
            
            printVideos(video: filtered)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
            // Delete the row from the data source
            
            saveVideos()
            
            
            
            
            
            // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .insert {
            
            
            
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }
        
    }
    
    
    func printVideos(video: [Video]) {
        
        
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
    
    @IBAction func unwindToVideoList(_ sender: UIStoryboardSegue) {
        
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
    
    // MARK: NSCoding
    
    func saveVideos() {
        
        
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(myVideos, toFile: Video.ArchiveURL.path)
        
        
        
        
        if !isSuccessfulSave {
            
            print("Failed to save videos...")
            
        }
        
    }
    
    func loadVideos() -> [Video]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
    }
    
    var activeDownloads = [String: Download]()
    
    let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
    
    var dataTask: URLSessionDataTask?
    
    lazy var downloadsSession: Foundation.URLSession = {
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
        
        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        return session
        
    }()
    
    // Called when the Download button for a track is tapped
    
    func startDownload(_ video: Video) {
        
        if let urlString = video.sourceUrl, let url =  URL(string: urlString) {
            
            let download = Download(url: urlString)
            
            download.downloadTask = downloadsSession.downloadTask(with: url)
            
            download.downloadTask!.resume()
            
            download.isDownloading = true
            
            activeDownloads[download.url] = download
            
        }
    }
    
    // Called when the Pause button for a track is tapped
    
    func pauseDownload(_ video: Video) {
        
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
    
    func cancelDownload(_ video: Video) {
        
        if let urlString = video.sourceUrl,
            
            let download = activeDownloads[urlString] {
            
            download.downloadTask?.cancel()
            
            activeDownloads[urlString] = nil
            
        }
        
    }
    
    // Called when the Resume button for a track is tapped
    
    func resumeDownload(_ video: Video) {
        
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
            
            for (index, video) in filtered.enumerated() {
                
                if url == video.sourceUrl! {
                    
                    return index
                    
                }
                
            }
            
        }
        
        return nil
        
    }
    
}

func correct(requestData data: Data?) -> Data? {
    guard let data = data else {
        return nil
    }
    if NSKeyedUnarchiver.unarchiveObject(with: data) != nil {
        return data
    }
    guard let archive = (try? PropertyListSerialization.propertyList(from: data, options: [.mutableContainersAndLeaves], format: nil)) as? NSMutableDictionary else {
        return nil
    }
    // Rectify weird __nsurlrequest_proto_props objects to $number pattern
    var k = 0
    while ((archive["$objects"] as? NSArray)?[1] as? NSDictionary)?.object(forKey: "$\(k)") != nil {
        k += 1
    }
    var i = 0
    while ((archive["$objects"] as? NSArray)?[1] as? NSDictionary)?.object(forKey: "__nsurlrequest_proto_prop_obj_\(i)") != nil {
        let arr = archive["$objects"] as? NSMutableArray
        if let dic = arr?[1] as? NSMutableDictionary, let obj = dic["__nsurlrequest_proto_prop_obj_\(i)"] {
            dic.setObject(obj, forKey: "$\(i + k)" as NSString)
            dic.removeObject(forKey: "__nsurlrequest_proto_prop_obj_\(i)")
            arr?[1] = dic
            archive["$objects"] = arr
        }
        i += 1
    }
    if ((archive["$objects"] as? NSArray)?[1] as? NSDictionary)?.object(forKey: "__nsurlrequest_proto_props") != nil {
        let arr = archive["$objects"] as? NSMutableArray
        if let dic = arr?[1] as? NSMutableDictionary, let obj = dic["__nsurlrequest_proto_props"] {
            dic.setObject(obj, forKey: "$\(i + k)" as NSString)
            dic.removeObject(forKey: "__nsurlrequest_proto_props")
            arr?[1] = dic
            archive["$objects"] = arr
        }
    }
    /* I think we have no reason to keep this section in effect
     for item in (archive["$objects"] as? NSMutableArray) ?? [] {
     if let cls = item as? NSMutableDictionary, cls["$classname"] as? NSString == "NSURLRequest" {
     cls["$classname"] = NSString(string: "NSMutableURLRequest")
     (cls["$classes"] as? NSMutableArray)?.insert(NSString(string: "NSMutableURLRequest"), at: 0)
     }
     }*/
    // Rectify weird "NSKeyedArchiveRootObjectKey" top key to NSKeyedArchiveRootObjectKey = "root"
    if let obj = (archive["$top"] as? NSMutableDictionary)?.object(forKey: "NSKeyedArchiveRootObjectKey") as AnyObject? {
        (archive["$top"] as? NSMutableDictionary)?.setObject(obj, forKey: NSKeyedArchiveRootObjectKey as NSString)
        (archive["$top"] as? NSMutableDictionary)?.removeObject(forKey: "NSKeyedArchiveRootObjectKey")
    }
    // Reencode archived object
    let result = try? PropertyListSerialization.data(fromPropertyList: archive, format: PropertyListSerialization.PropertyListFormat.binary, options: PropertyListSerialization.WriteOptions())
    return result
}

func getResumeDictionary(_ data: Data) -> NSMutableDictionary? {
    // In beta versions, resumeData is NSKeyedArchive encoded instead of plist
    var iresumeDictionary: NSMutableDictionary? = nil
    if #available(iOS 10.0, OSX 10.12, *) {
        var root : AnyObject? = nil
        let keyedUnarchiver = NSKeyedUnarchiver(forReadingWith: data)
        
        do {
            root = try keyedUnarchiver.decodeTopLevelObject(forKey: "NSKeyedArchiveRootObjectKey") ?? nil
            if root == nil {
                root = try keyedUnarchiver.decodeTopLevelObject(forKey: NSKeyedArchiveRootObjectKey)
            }
        } catch {}
        keyedUnarchiver.finishDecoding()
        iresumeDictionary = root as? NSMutableDictionary
        
    }
    
    if iresumeDictionary == nil {
        do {
            iresumeDictionary = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions(), format: nil) as? NSMutableDictionary;
        } catch {}
    }
    
    return iresumeDictionary
}

func correctResumeData(_ data: Data?) -> Data? {
    let kResumeCurrentRequest = "NSURLSessionResumeCurrentRequest"
    let kResumeOriginalRequest = "NSURLSessionResumeOriginalRequest"
    
    guard let data = data, let resumeDictionary = getResumeDictionary(data) else {
        return nil
    }
    
    resumeDictionary[kResumeCurrentRequest] = correct(requestData: resumeDictionary[kResumeCurrentRequest] as? Data)
    resumeDictionary[kResumeOriginalRequest] = correct(requestData: resumeDictionary[kResumeOriginalRequest] as? Data)
    
    let result = try? PropertyListSerialization.data(fromPropertyList: resumeDictionary, format: PropertyListSerialization.PropertyListFormat.xml, options: PropertyListSerialization.WriteOptions())
    return result
}


extension URLSession {
    func correctedDownloadTask(withResumeData resumeData: Data) -> URLSessionDownloadTask {
        let kResumeCurrentRequest = "NSURLSessionResumeCurrentRequest"
        let kResumeOriginalRequest = "NSURLSessionResumeOriginalRequest"
        
        let cData = correctResumeData(resumeData) ?? resumeData
        let task = self.downloadTask(withResumeData: cData)
        
        // a compensation for inability to set task requests in CFNetwork.
        // While you still get -[NSKeyedUnarchiver initForReadingWithData:]: data is NULL error,
        // this section will set them to real objects
        if let resumeDic = getResumeDictionary(cData) {
            if task.originalRequest == nil, let originalReqData = resumeDic[kResumeOriginalRequest] as? Data, let originalRequest = NSKeyedUnarchiver.unarchiveObject(with: originalReqData) as? NSURLRequest {
                task.setValue(originalRequest, forKey: "originalRequest")
            }
            if task.currentRequest == nil, let currentReqData = resumeDic[kResumeCurrentRequest] as? Data, let currentRequest = NSKeyedUnarchiver.unarchiveObject(with: currentReqData) as? NSURLRequest {
                task.setValue(currentRequest, forKey: "currentRequest")
            }
        }
        
        return task
    }
}

// MARK: - NSURLSessionDelegate

extension MyVideosViewController: URLSessionDelegate {
    
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

extension MyVideosViewController: URLSessionDownloadDelegate {
    
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
            
            activeDownloads[url] = nil
            
            if let videoIndex = videoIndexForDownloadTask(downloadTask) {
                
                DispatchQueue.main.async(execute: {
                    
                    self.tableView.reloadRows(at: [IndexPath(row: videoIndex, section: 0)], with: .none)
                    
                })
                
            }
            
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        if let downloadUrl = downloadTask.originalRequest?.url?.absoluteString,
            
            let download = activeDownloads[downloadUrl] {
            // 2
            
            download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            // 3
            let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: ByteCountFormatter.CountStyle.binary)
            // 4
            if let videoIndex = videoIndexForDownloadTask(downloadTask), let videoCell = tableView.cellForRow(at: IndexPath(row: videoIndex, section: 0)) as? VideoCell {
                
                DispatchQueue.main.async(execute: {
                    
                    videoCell.progressView.progress = download.progress
                    
                    //videoCell.progressLabel.text =  String(format: "%.1f%% of %@",  download.progress * 100, totalSize)
                    
                })
                
            }
            
        }
        
    }
    
}

