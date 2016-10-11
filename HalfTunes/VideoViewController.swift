//
//  VideoViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation
import MediaPlayer
import UIKit

import AVFoundation
import AVKit


class VideoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource {
    
    
    var search = VideoSearch()
    
    var recommendedVideos = [Video]()
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as? MainVideoCell
        
        
        cell?.titleLabel?.text = recommendedVideos[indexPath.row].title
        
          cell?.thumbnailView.image = recommendedVideos[indexPath.row].thumbnail
        
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.low).async {  //generate thumbnail in bacground
            
            do {
               self.recommendedVideos[indexPath.row].generateThumbnail()
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return recommendedVideos.count
    }
    
    

    
    // MARK: Properties
    
    @IBOutlet weak var thumbnailView: UIImageView!
    
   
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
  
    @IBOutlet weak var thumbnailButton: UIButton!
    
    @IBOutlet weak var addVideoButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var moviePlayer : AVPlayer?
    
    var video: Video?
    
    var myVideos = [Video]()
    
    
    
    //   var activeDownloads = [String: Download]()
    
    var defaultSession : Foundation.URLSession? = nil
    
    var dataTask: URLSessionDataTask?
    
    var downloadsSession: Foundation.URLSession?
    
    var timer : Timer?
    
    
    
    override func viewDidLoad() {
        
        
        recommendedVideos = search.getRecentLimited()
        
       
        
        addVideoButton.setTitle("Download", for: UIControlState.selected)
        
        super.viewDidLoad()
        
        _ = self.downloadsSession
        
        if let video = video {
            
            navigationItem.title = video.title
            
            titleLabel.text   = video.title
            
            descriptionLabel.text = video.comments
            
          
            
            
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {  //generate thumbnail in bacground
                
                  video.generateThumbnail() 
                
                DispatchQueue.main.async {
                    
                    self.thumbnailView.image = video.thumbnail
                    
                }
                
            }
            
            thumbnailView.image = video.thumbnail
            
        }
        
        if(loadVideos() != nil) {
            
            
            self.myVideos = loadVideos()!
            
            
        
            
        }
        
        if (hasSavedVideo()) {
            
            
            toggleAddButton()
        }
        

       // timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "setProgressBar", userInfo: nil, repeats: true)
    
    }
    
    func setProgressBar() {
        
        var tempDownload = GlobalVariables.sharedManager.getDownload(downloadUrl: (self.video?.sourceUrl)!)
        
        
        if( tempDownload?.progress !=  nil ) {
            
            
           
            
            print(tempDownload!.progress)
            
            self.progressView.setProgress(tempDownload!.progress, animated: true)
                
            
       
        } else {
            
     
                hideDownloadControls()
               timer?.invalidate()
            
           
                
                self.toggleAddButton()
                
    
                   }
        
        
        //var tempDownload = GlobalVariables.sharedManager.getDownload(downloadUrl: (self.video?.sourceUrl)!)
    
    }
    
    func hideDownloadControls() {
        
        var showDownloadControls = false
        
     
  
        
        self.cancelButton.isHidden = !showDownloadControls
        
        self.progressView.isHidden = !showDownloadControls
        
        
    }
    
    
    func setActiveDownloads( downloads: inout [String: Download]) {
        
        //   self.activeDownloads = downloads

    }
    
    
    func setDefaultSession(defaultSession: inout Foundation.URLSession) {
        
        self.defaultSession = defaultSession
        
    }
    
    func setDataTask(dataTask: inout URLSessionDataTask) {
        
        self.dataTask = dataTask
        
    }
    
    func setDownloadsSession(downloadsSession: inout Foundation.URLSession) {
        
        self.downloadsSession = downloadsSession
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if(loadVideos() != nil) {

            self.myVideos = loadVideos()!
            
        }
        
        toggleAddButton()
        var showDownloadControls = false
        
        
        if ( video?.sourceUrl != nil && (GlobalVariables.sharedManager.activeDownloads[(video?.sourceUrl!)!] != nil))  {
            
           
            
            let download = GlobalVariables.sharedManager.activeDownloads[(video!.sourceUrl!)]
            
           
            
            showDownloadControls = true
            
            self.progressView.progress = (download?.progress)!
            
            
            
          
            
            if(download?.isDownloading == true) {
               
                
                addVideoButton.setTitle("Pause", for: UIControlState.selected)
                addVideoButton.isSelected = true
                
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "setProgressBar", userInfo: nil, repeats: true)
                
            } else if (download?.isDownloading == false)  {
                
                
                
                addVideoButton.setTitle("Resume", for: UIControlState.selected)
                addVideoButton.isSelected = true
                
                timer!.invalidate()
            }
            
            
            
            //cell.progressLabel.text = (download.isDownloading) ? "Downloading..." : "Paused"
            
          
            
        } else {
            
     
            
        }
 
 
        
        self.progressView.isHidden = !showDownloadControls
  
        self.cancelButton.isHidden = !showDownloadControls
        
    }
    
    
    func loadVideos() -> [Video]? {
        
        
       var video = NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
      
    
        return NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddVideoMode = presentingViewController is UINavigationController
        
        if isPresentingInAddVideoMode {
            
            dismiss(animated: true, completion: nil)
            
        } else {
            
            navigationController!.popViewController(animated: true)
            
        }
        
    }
    
    
    @IBAction func addVideo(_ sender: AnyObject) {
        
        if(addVideoButton.titleLabel?.text == "+ Add"){
        if(!addVideoButton.isSelected) {
            saveVideos()
        }
        }
        
        
        if(addVideoButton.titleLabel?.text == "Download"){
            
         downloadTapped()
            
        }
        
        if(addVideoButton.titleLabel?.text == "Pause"){
            
            pauseDownload(video!)
            
        }
        
        if(addVideoButton.titleLabel?.text == "Resume"){
            
             resumeDownload(video!)
            
        }
        
    }
    
    func hasSavedVideo() -> Bool {
        
        for vid in myVideos {
            
            if (vid.title == video?.title) {
                
                return true
            }
            
        }
        
        
        return false
    }
    
    func saveVideos() {
        
        
        myVideos.append(video!)
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(myVideos, toFile: Video.ArchiveURL.path)
        print("saved the video")
        
        if (isSuccessfulSave) {
            
            toggleAddButton()
        } else {
            
            print("Failed to save videos...")
            
        }
        
    }
    
    @IBAction func playVideo(_ sender: AnyObject) {
        
        let videoPath = Bundle.main.path(forResource: video?.sourceUrl, ofType:"mp4")
        
        //Make a URL from your path
        
        //Initalize the movie player
        
        if (!localFileExistsForVideo(video!)) {
            
            if let urlString = video?.sourceUrl, let url = localFilePathForUrl(urlString) {
                
                let fileUrl = URL(string: urlString)
                
                let moviePlayer:AVPlayer! = AVPlayer(url: fileUrl!)
                
                let playerViewController = AVPlayerViewController()
                
                playerViewController.player = moviePlayer
                
                self.present(playerViewController, animated: true) {
                    
                    playerViewController.player!.play()
                }
                
            }
            
        } else {
            
            print("local file exists for: \(video?.title)")
            
            playDownload(video!)
            
        }
        
    }
    
    func playDownload(_ video: Video) {
        
        if let urlString = video.sourceUrl, let url = localFilePathForUrl(urlString) {
            
            let moviePlayer:AVPlayer! = AVPlayer(url: url)
            
            let playerViewController = AVPlayerViewController()
            
            playerViewController.player = moviePlayer
            
            // presentMoviePlayerViewControllerAnimated(moviePlayer)
            
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            
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
    
    func toggleAddButton() {
        
        if(video != nil) {
        if(localFileExistsForVideo(video!)) {
            
            addVideoButton.setTitle("Downloaded", for: UIControlState.selected)
            
            
            addVideoButton.isSelected = true
            
        } else {
            
            
            if(hasSavedVideo()) {
                addVideoButton.setTitle("Download", for: UIControlState.selected)
                addVideoButton.isSelected = true
                
            } else {
                
                addVideoButton.setTitle("+ Add", for: UIControlState.normal)
                
                addVideoButton.isSelected = false
            }
            
        }
            
        }
    }
    
 func downloadTapped() {
    
      
        
        var showDownloadControls = false
        //   print(parentView?.myVideos)
        startDownload(video!)
    
    
         addVideoButton.setTitle("Pause", for: UIControlState.selected)
        
        if let download = GlobalVariables.sharedManager.activeDownloads[video!.sourceUrl!] {
            
            
       
            
            showDownloadControls = true
            
            self.progressView.progress = (download.progress)
            
              timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "setProgressBar", userInfo: nil, repeats: true)
            
            //cell.progressLabel.text = (download.isDownloading) ? "Downloading..." : "Paused"
            
          
            
            
            
        }
        
        self.progressView.isHidden = !showDownloadControls
        
        
        let downloaded = localFileExistsForVideo(video!)
        
        
    
        
        self.cancelButton.isHidden = !showDownloadControls
        
    }
    @IBAction func cancelTapped(_ sender: AnyObject) {
        
        cancelDownload(video!)
        
    }
    
    @IBAction func pauseTapped(_ sender: AnyObject) {
        
        pauseDownload(video!)
        
    }
    
    
    func startDownload(_ video: Video) {
       
        if let urlString = video.sourceUrl, let url =  URL(string: urlString) {
        
            let download = Download(url: urlString)
            
            download.downloadTask = downloadsSession?.downloadTask(with: url)
            
            download.downloadTask!.resume()
            
            download.isDownloading = true
            
            GlobalVariables.sharedManager.activeDownloads[download.url] = download
            
        }
    }
    
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
                
                print("paused")
                
                timer!.invalidate()
                
                addVideoButton.setTitle("Resume", for: UIControlState.selected)

                
            
                
                
                
            }
            
        }
        
    }
    
    func cancelDownload(_ video: Video) {
        
        if let urlString = video.sourceUrl,
            
            let download = GlobalVariables.sharedManager.activeDownloads[urlString] {
            
            download.downloadTask?.cancel()
            print("canceled")
          
            GlobalVariables.sharedManager.activeDownloads[urlString] = nil
            
         
            
            timer?.invalidate()
            toggleAddButton()
            
               hideDownloadControls()
            
        }
        
    }
    
    func resumeDownload(_ video: Video) {
        
        
          addVideoButton.setTitle("Pause", for: UIControlState.selected)
        
        if let urlString = video.sourceUrl,
            
            let download = GlobalVariables.sharedManager.activeDownloads[urlString] {
            
            if let resumeData = download.resumeData {
                
              
                
                download.downloadTask = downloadsSession?.correctedDownloadTask(withResumeData: resumeData)
                
                download.downloadTask!.resume()
                
                download.isDownloading = true
                
                
                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "setProgressBar", userInfo: nil, repeats: true)
                
                
             
                
                
            } else if let url = URL(string: download.url) {
                
             
                download.downloadTask = downloadsSession?.downloadTask(with: url)
                
                download.downloadTask!.resume()
                
                download.isDownloading = true
                
            }
            
        }
        
    }
    
    
    


    
}











