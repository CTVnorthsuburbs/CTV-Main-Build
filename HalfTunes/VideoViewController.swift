//
//  VideoViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  
//

import Foundation
import MediaPlayer
import UIKit

import AVFoundation
import AVKit

//var myVideos = [Video]()



class VideoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    var childView: SuggestedVideosTableViewController {
        
        get {
            let ctrl = childViewControllers.first(where: { $0 is SuggestedVideosTableViewController })
            
            
            return ctrl as! SuggestedVideosTableViewController
        }
    }
    
    @IBOutlet weak var child: UIView!
    
    // MARK: Properties
    
    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var thumbnailButton: UIButton!
    
    let playerViewController = YourVideoPlayer()
    
    var moviePlayer : AVPlayer?
    
    var video: Video?
    
    
    var videoLoaded: Bool = false
    
    
    var currentCategory: Category?
    var webView: UIWebView?
    
    
    
    //   var activeDownloads = [String: Download]()
    
    var defaultSession : Foundation.URLSession? = nil
    
    var dataTask: URLSessionDataTask?
    
    var downloadsSession: Foundation.URLSession?
    
    var timer : Timer?
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    func hidePlayer() {
  
        

        
        self.thumbnailButton.isHidden = true

    }
    
    func showPlayer() {

        self.thumbnailButton.isHidden = false

    }
    
    
    func setCategory(category: Category) {
        
        self.currentCategory = category
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        self.thumbnailButton.isHidden = true
        
        
        playerViewController.player?.pause()
        
        
        
        webView? = UIWebView()
        
        
        
        
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        
       
    
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        //self.thumbnailButton.isHidden = true     //Chnage this maybe
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.shouldRotate = false// or false to disable rotation
        
        if(videoLoaded == false) {
            
            
            
        showPlayer()
            
            
        }
        if(video?.getIsEvent() == true) {
            
            
            
            if (video?.eventDate?.checkIfDateTimeIsNow())! {
                
                
                showPlayer()
                
            } else {
           hidePlayer()
            }
            
        }
        
    }
    
    func loadVideoThumbnail(video: Video) {
        
        DispatchQueue.global(qos: .background).async {
            
            
            
            
            if(video.fileName != nil  && self.currentCategory?.videoType != VideoType.youtube) {
                
                if(video.fileName != 1) {
                    
                    
                    video.thumbnail = search.getThumbnail(id: video.fileName!)
                    
                    
                    if(video.thumbnail == nil) {
                        
                        
                        video.generateThumbnail()
                        
                        
                    }
                    
                }
                
                
            }
            
            
            self.thumbnailView.image = video.thumbnail
            
            
            if(   self.thumbnailView.image == nil &&  video.fileName != 1) {
                
                
                
                video.generateThumbnail()
                self.thumbnailView.image = video.thumbnail
                
            } else if (self.thumbnailView.image == nil  && video.fileName == 1) {
                
                
                if(video.hasThumbnailUrl()) {
                    
                    
                    
                    video.thumbnail = search.getThumbnail(url: video.thumbnailUrl!)
                    
                    self.thumbnailView.image = video.thumbnail
                    
                }
                
            }
            
            
            
            DispatchQueue.main.async(){
                
                LoadingOverlay.shared.hideOverlayView()
                
            }
            
            
            
        }
        
    }
    
    
    
    func loadEventThumbnail(video: Video) {
        
        DispatchQueue.global(qos: .background).async {
            
            
            
            
            //   cells.thumbnail.image = self.search.getThumbnail(url: (videos[indexPath.item].thumbnailUrl)!)
            
            //   cells.thumbnail.image = cells.thumbnail.image?.cropBottomImage(image: cells.thumbnail.image!)
            
            
            
            video.thumbnail =  search.getThumbnail(url: (video.thumbnailUrl)!)
            
            video.thumbnail =  video.thumbnail?.cropEventImage()
            
            
            
            
            self.thumbnailView.image = video.thumbnail
            
            
            
            DispatchQueue.main.async(){
                
                LoadingOverlay.shared.hideOverlayView()
                
            }
            
            
            
        }
        
    }
    
    
    func loadVideoDescription(video: Video) {
        
        let date =  video.eventDate
        
        self.childView.dateLabel.text = date?.convertDateToString()
        
        
        self.navigationItem.title = video.title
        
        self.childView.titleLabel.text   = video.title
        
        self.childView.descriptionLabel.text = video.comments
        
        self.video = video
        
        self.childView.parentView = self
        
        self.childView.setVideo(video: video)
        
        
        
        
    }
    
    
    
    func loadEventDescription(video: Video) {
        
        let date =  video.getStartDate()
        
        let endDate = video.getEndDate()
        
        if (date?.checkIfDateTimeIsTomorrow())!  {
            
            self.childView.dateLabel.text = "Tomorrow"
            
        } else if (date?.checkIfDateTimeIsToday())! {
            
            
            
            self.childView.dateLabel.text = "Today"
            
            
        } else {
      
        self.childView.dateLabel.text = date?.convertDateToString()
        
        }
        
        self.navigationItem.title = video.title
        
        self.childView.titleLabel.text   = video.title
        
        self.childView.descriptionLabel.font = self.childView.descriptionLabel.font.withSize(12)
        
        self.childView.descriptionLabel.text = String("Start Time: \(date!.convertDateToTimeString())\nEnd Time: \(endDate!.convertDateToTimeString())")
        
        self.video = video
        
        self.childView.parentView = self
        
        self.childView.setVideo(video: video)
        
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        
        showPlayer()
     
        
        self.childView.addVideoButton.setTitle("Download", for: UIControlState.selected)
        
        super.viewDidLoad()
        
        _ = self.downloadsSession
        
        if(self.currentCategory != nil) {
            
            
            
            self.childView.setCategory(category: self.currentCategory!)
            
            
            
        } else {
            
            
            self.currentCategory = category
            
            
            
            
            self.childView.setCategory(category: self.currentCategory!, section: selectedSection)
            
            
            
        }
        
        
        
        
        if(self.video == nil){
            
            
            print("The video did not load into Video View Controller")
        }
        while(self.video == nil) {
            
            var i = 0
            
            i = i + i
            
        }
        
        if let video = self.video {
            
            if(video.getIsEvent() == true) {
                
                

               
                
                loadEventDescription(video: video)
                
                loadEventThumbnail(video: video)
                
   
                videoLoaded = false
                
            } else {
                
                loadVideoDescription(video: video)
                
                loadVideoThumbnail(video: video)
                
                 showPlayer()
                
            }
            
        }
        
        
        //thumbnailView.image = video.thumbnail
        
        
        
        if(self.loadVideos() != nil) {
            
            
            myVideos = self.loadVideos()!
            
        }
        
        if (self.hasSavedVideo()) {
            
            
            self.toggleAddButton()
        }
        
        //   LoadingOverlay.shared.hideOverlayView()
        // timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "setProgressBar", userInfo: nil, repeats: true)
        self.thumbnailButton.isHidden = false
    }
    
    
    
    
    
    
    func setProgressBar() {
        
        let tempDownload = GlobalVariables.sharedManager.getDownload(downloadUrl: (self.video?.sourceUrl)!)
        
        
        if( tempDownload?.progress !=  nil ) {
            
            
            
            
            print(tempDownload!.progress)
            
            childView.progressView.setProgress(tempDownload!.progress, animated: true)
            
            
            
        } else {
            
            
            hideDownloadControls()
            timer?.invalidate()
            
            
            
            self.toggleAddButton()
            
            
        }
        
        
        //var tempDownload = GlobalVariables.sharedManager.getDownload(downloadUrl: (self.video?.sourceUrl)!)
        
    }
    
    func hideDownloadControls() {
        
        let showDownloadControls = false
        
        
        
        
        childView.cancelButton.isHidden = !showDownloadControls
        
        childView.progressView.isHidden = !showDownloadControls
        
        
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
        
        // hidePlayer()
        
        
        if(loadVideos() != nil) {
            
            myVideos = loadVideos()!
            
        }
        
        
        
        
        
        
        toggleAddButton()
        
        
        var showDownloadControls = false
        
        
        if ( video?.sourceUrl != nil && (GlobalVariables.sharedManager.activeDownloads[(video?.sourceUrl!)!] != nil))  {
            
            
            
            let download = GlobalVariables.sharedManager.activeDownloads[(video!.sourceUrl!)]
            
            
            
            showDownloadControls = true
            
            
            
            
            self.childView.progressView.progress = (download?.progress)!
            
            
            
            
            
            if(download?.isDownloading == true) {
                
                
                childView.addVideoButton.setTitle("Pause", for: UIControlState.selected)
                childView.addVideoButton.isSelected = true
                
                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "setProgressBar", userInfo: nil, repeats: true)
                
            } else if (download?.isDownloading == false)  {
                
                
                
                childView.addVideoButton.setTitle("Resume", for: UIControlState.selected)
                childView.addVideoButton.isSelected = true
                
                timer?.invalidate()
            }
            
            
            
            //cell.progressLabel.text = (download.isDownloading) ? "Downloading..." : "Paused"
            
            
            
        } else {
            
            
            
        }
        
        
        
        childView.progressView.isHidden = !showDownloadControls
        
        childView.cancelButton.isHidden = !showDownloadControls
        
        
        
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        timer?.invalidate()
        
    }
    
    
    
    func loadVideos() -> [Video]? {
        
        
     //   var video = NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
        
        
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
    
    
    func addVideo(_ sender: AnyObject) {
        
        if(childView.addVideoButton.titleLabel?.text == "+ Add"){
            if(!childView.addVideoButton.isSelected) {
                saveVideos()
            }
        }
        
        
        if(childView.addVideoButton.titleLabel?.text == "Download"){
            
            downloadTapped()
            
        }
        
        if(childView.addVideoButton.titleLabel?.text == "Pause"){
            
            pauseDownload(video!)
            
        }
        
        if(childView.addVideoButton.titleLabel?.text == "Resume"){
            
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
        
        
        if (isSuccessfulSave) {
            
            toggleAddButton()
        } else {
            
            print("Failed to save videos...")
            
        }
        
    }
    
    
    
    
    @IBAction func playVideo(_ sender: AnyObject) {
        
        
        self.thumbnailButton.isHidden = true
        
        self.videoLoaded = true
        
        
        if(currentCategory?.videoType == VideoType.youtube) {
            
            
            
            
            webView = UIWebView(frame: self.thumbnailView.frame)
            
            
            self.view.addSubview(webView!)
            self.view.bringSubview(toFront: webView!)
            
            
            
            //  UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.shouldRotate = true // or false to disable rotation
            
            
            
            webView?.allowsInlineMediaPlayback = true
            webView?.mediaPlaybackRequiresUserAction = false
            
            var videoID = ""
            
            
            videoID = (video?.sourceUrl)!     // https://www.youtube.com/watch?v=28myxjncnDM     http://www.youtube.com/embed/28myxjncnDM
            
            let embededHTML = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='\(self.thumbnailView.frame.size.width)' height='\(self.thumbnailView.frame.size.height)' src='http://www.youtube.com/embed/\(videoID)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"
            
            
            
            
            
            webView?.loadHTMLString(embededHTML, baseURL: Bundle.main.resourceURL)
            
            
            
            
            
            
        } else {
            
            
            if(video?.fileName == 1 && currentCategory?.videoType != VideoType.youtube) {
                
                
                if let urlString = video?.sourceUrl, let url = localFilePathForUrl(urlString) {
                    
                    
                    
                    
                    
                    
                    
                    let fileUrl = URL(string: urlString)
                    
                    let moviePlayer:AVPlayer! = AVPlayer(url: fileUrl!)
                    
                    
                    
                    
                    playerViewController.player = moviePlayer
                    
                    
                    self.addChildViewController(playerViewController)
                    self.thumbnailView.addSubview(playerViewController.view)
                    playerViewController.view.frame = self.thumbnailView.bounds
                    
                    playerViewController.allowsPictureInPicturePlayback = true
                    
                    playerViewController.showsPlaybackControls = true
                    
                    
                    
                    
                    
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    //  let value = UIInterfaceOrientation.portrait.rawValue
                    // UIDevice.current.setValue(value, forKey: "orientation")
                    
                    
                    
                    
                    self.thumbnailButton.isHidden = true
                    playerViewController.player!.play()
                    
                    //  appDelegate.shouldRotate = true // or false to disable rotation
                    
                    
                    
                }
                
                
                
                
                
                
                
                
                
                
            } else {
                
                let videoPath = Bundle.main.path(forResource: video?.sourceUrl, ofType:"mp4")
                
                //Make a URL from your path
                
                //Initalize the movie player
                
                if (!localFileExistsForVideo(video!)) {
                    
                    if let urlString = video?.sourceUrl, let url = localFilePathForUrl(urlString) {
                        
                        
                        
                        
                        
                        
                        
                        let fileUrl = URL(string: urlString)
                        
                        let moviePlayer:AVPlayer! = AVPlayer(url: fileUrl!)
                        
                        
                        
                        
                        playerViewController.player = moviePlayer
                        
                        
                        self.addChildViewController(playerViewController)
                        self.thumbnailView.addSubview(playerViewController.view)
                        playerViewController.view.frame = self.thumbnailView.bounds
                        
                        playerViewController.allowsPictureInPicturePlayback = true
                        
                        playerViewController.showsPlaybackControls = true
                        
                        
                        
                        
                        
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        //  let value = UIInterfaceOrientation.portrait.rawValue
                        // UIDevice.current.setValue(value, forKey: "orientation")
                        
                        
                        
                        
                        self.thumbnailButton.isHidden = true
                        playerViewController.player!.play()
                        
                        //  appDelegate.shouldRotate = true // or false to disable rotation
                        
                        
                        
                    }
                    
                } else {
                    
                    print("local file exists for: \(video?.title)")
                    
                    
                    
                    
                    
                    
                    if let urlString = video?.sourceUrl, let url = localFilePathForUrl(urlString) {
                        
                        
                        
                        
                        print("URL: \(url)")
                        
                        let moviePlayer:AVPlayer! = AVPlayer(url: url)
                        
                        
                        
                        
                        playerViewController.player = moviePlayer
                        
                        self.addChildViewController(playerViewController)
                        
                        self.thumbnailView.addSubview(playerViewController.view)
                        
                        playerViewController.view.frame = self.thumbnailView.bounds
                        
                        playerViewController.allowsPictureInPicturePlayback = true
                        
                        playerViewController.showsPlaybackControls = true

                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        //  let value = UIInterfaceOrientation.portrait.rawValue
                        // UIDevice.current.setValue(value, forKey: "orientation")
                        
                        self.thumbnailButton.isHidden = true
                        
                        playerViewController.player!.play()

                    }
                    
                    
                    
                }
                
            }
            
            
        }
        
        /*
         
         let webView = UIWebView(frame: self.thumbnailView.frame)
         
         self.view.addSubview(webView)
         self.view.bringSubview(toFront: webView)
         
         webView.allowsInlineMediaPlayback = true
         webView.mediaPlaybackRequiresUserAction = false
         
         var videoID = ""
         
         
         videoID = (video?.sourceUrl)!     // https://www.youtube.com/watch?v=28myxjncnDM     http://www.youtube.com/embed/28myxjncnDM
         
         let embededHTML = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='\(self.thumbnailView.frame.size.width)' height='\(self.thumbnailView.frame.size.height)' src='http://www.youtube.com/embed/\(videoID)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"
         
         
         
         
         
         
         webView.loadHTMLString(embededHTML, baseURL: Bundle.main.resourceURL)
         
         
         */
        
        
        
        
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
        if(url != nil ) {       //added this to fix error
            
            let lastPathComponent = url?.lastPathComponent
            
            let fullPath = documentsPath.appendingPathComponent(lastPathComponent!)
            
            return URL(fileURLWithPath:fullPath)
        }
        return nil
        
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
                
                childView.addVideoButton.setTitle("Downloaded", for: UIControlState.selected)
                
                
                childView.addVideoButton.isSelected = true
                
            } else {
                
                
                if(hasSavedVideo()) {
                    
                    
                    if(currentCategory?.videoType != VideoType.youtube &&  video?.getIsEvent() == false ) {
                        
                        childView.addVideoButton.setTitle("Download", for: UIControlState.selected)
                        
                    } else {
                        
                        
                        childView.addVideoButton.setTitle("Added", for: UIControlState.selected)
                        
                    }
                    
                    
                    childView.addVideoButton.isSelected = true
                    
                } else {
                    
                    childView.addVideoButton.setTitle("+ Add", for: UIControlState.normal)
                    
                    childView.addVideoButton.isSelected = false
                }
                
            }
            
        }
    }
    
    func downloadTapped() {
        
        
        
        var showDownloadControls = false
        //   print(parentView?.myVideos)
        startDownload(video!)
        
        
        childView.addVideoButton.setTitle("Pause", for: UIControlState.selected)
        
        if let download = GlobalVariables.sharedManager.activeDownloads[video!.sourceUrl!] {
            
            
            
            
            showDownloadControls = true
            
            childView.progressView.progress = (download.progress)
            
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "setProgressBar", userInfo: nil, repeats: true)
            
            //cell.progressLabel.text = (download.isDownloading) ? "Downloading..." : "Paused"
            
            
            
            
            
        }
        
        childView.progressView.isHidden = !showDownloadControls
        
        
        let downloaded = localFileExistsForVideo(video!)
        
        
        
        
        childView.cancelButton.isHidden = !showDownloadControls
        
    }
    func cancelTapped(_ sender: AnyObject) {
        
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
                
                timer?.invalidate()
                
                childView.addVideoButton.setTitle("Resume", for: UIControlState.selected)
                
                
                
                
                
                
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
        
        
        childView.addVideoButton.setTitle("Pause", for: UIControlState.selected)
        
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




class YourVideoPlayer: AVPlayerViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.bounds == contentOverlayView?.bounds {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.shouldRotate = false
            
            
        } else {
            
            
            //  UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.shouldRotate = true // or false to disable rotation
            
            
        }
    }
    
    
    
}
















