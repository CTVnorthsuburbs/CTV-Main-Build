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

import AVKit


func convertDateToString(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    dateFormatter.dateFormat = "MM-dd-yyyy"
    
    let timeString = dateFormatter.string(from: date)
    
    return timeString
    
}


class GlobalVariables {
    
    
    
    
    // These are the properties you can store in your singleton
    var activeDownloads = [String: Download]()
    var progress : Float = 0
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
        
    }
    
    func getDownload(downloadUrl: String)-> Download? {
        
        if((activeDownloads[downloadUrl]) != nil) {
            let download = activeDownloads[downloadUrl]
            
            return download
        }
        
        return nil
        
    }
}

/// The MyVideosViewController class contains the controller that handles the My Videos table view within the Search View



var myVideos = [Video]()



class MyVideosViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, VideoCellDelegate {
    
    var videos = [Video]()
    
    var searchBar: UISearchBar!
    
    var searchResults = [Video]()          //this holds the list of all videos
    
    //this holds the videos saved to myVideos
    
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
        
        if(loadVideos() != nil) {
            
            
            myVideos = loadVideos()!
            
        }
        _ = self.downloadsSession
        //  self.filtered = self.myVideos
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
        //    self.tableView.reloadData()
        
        
        
        if(loadVideos() != nil) {
            
            
            // myVideos = loadVideos()!
            
        }
        self.filtered = myVideos
        // super.viewWillAppear(animated)
        tableView.reloadData()
        
        
        
        for _ in GlobalVariables.sharedManager.activeDownloads {
            
            
            print("active downloads : ")
            print(GlobalVariables.sharedManager.activeDownloads)
        }
        
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.shouldRotate = false // or false to disable rotation
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
            
            if let urlString = video.sourceUrl, let _ = localFilePathForUrl(urlString) {
                print("url string \(urlString)")
                
                let fileUrl = URL(string: urlString)
                
                
             
                
           
                let asset = AVAsset(url: fileUrl!)
                
                let playerItem = AVPlayerItem(asset: asset)
                
                let fullScreenPlayer = AVPlayer(playerItem: playerItem)
                
                fullScreenPlayer.play()
                
                let fullScreenPlayerViewController = AVPlayerViewController()
                
                fullScreenPlayerViewController.player = fullScreenPlayer
                
                present(fullScreenPlayerViewController, animated: true, completion: nil)
                
               // let moviePlayer:MPMoviePlayerViewController! = MPMoviePlayerViewController(contentURL: fileUrl)
                
                
                
              //  presentMoviePlayerViewControllerAnimated(moviePlayer)
                
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
        
        
        cell.thumbnailView.setRadius(radius: imageRadius)
        
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
        
        if(video?.fileName == 1 || video?.getIsEvent() == true) {
            
            
            
            cell.downloadButton.isHidden = true
        }
        
        if(video?.getIsEvent() == true) {
            
            
            cell.thumbnailButton.isHidden = true
            
        }
        
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
            
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.shouldRotate = true // or false to disable rotation
            
            
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
            
            
            LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
            
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                
                
                
                let videoDetailViewController = segue.destination as! VideoViewController
                
                // Get the cell that generated this segue.
                
                if let selectedVideoCell = sender as? VideoCell {
                    
                    let indexPath = self.tableView.indexPath(for: selectedVideoCell)!
                    
                    
                    let selectedVideo = myVideos[indexPath.row]
                    
                    videoDetailViewController.video = selectedVideo
                    
                    //    videoDetailViewController.setActiveDownloads(downloads: &activeDownloads)
                    
                    
                    
                    
                    
                    
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
                
                
                
                
                DispatchQueue.main.async( execute: {
                    
                    LoadingOverlay.shared.hideOverlayView()
                })
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
            let parentVC = parent as? SearchViewController
            
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
        
        let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
        
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
            
            
            
            
            let asset = AVAsset(url: url)
            
            let playerItem = AVPlayerItem(asset: asset)
            
            let fullScreenPlayer = AVPlayer(playerItem: playerItem)
            
            fullScreenPlayer.play()
            
            let fullScreenPlayerViewController = AVPlayerViewController()
            
            fullScreenPlayerViewController.player = fullScreenPlayer
            
            present(fullScreenPlayerViewController, animated: true, completion: nil)
            
            
            
            //  UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.shouldRotate = true // or false to disable rotation
            
            
            
           // presentMoviePlayerViewControllerAnimated(moviePlayer)
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
            
           
            
            
            let path = localUrl.path
            
            do { try FileManager.default.removeItem(atPath: path)
                
          
                
            } catch {
                
                
               
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
            _ = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: ByteCountFormatter.CountStyle.binary)
            // 4
            
            
            DispatchQueue.global(qos: .userInitiated).async {
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    
                    
                    if let videoIndex = self.videoIndexForDownloadTask(downloadTask), let videoCell = self.tableView.cellForRow(at: IndexPath(row: videoIndex, section: 0)) as? VideoCell {
                        
                        
                        
                        
                        
                        videoCell.progressView.progress = download.progress
                        
                        let temp =  GlobalVariables.sharedManager.getDownload(downloadUrl: downloadUrl)
                        
                        temp?.progress = download.progress
                        
                        
                        
                        
                        
                    }
                    
                }}
            
        }
        
    }
    
}


