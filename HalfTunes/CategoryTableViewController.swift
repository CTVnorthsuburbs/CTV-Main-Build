//
//  CategoryTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 11/1/16.
//
//

import Foundation

import UIKit


import MediaPlayer

class CategoryTableViewController: UITableViewController {
    
    var categorySection: Section?
    

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        }
        
        return .none
    }
    

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addVideoButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet var suggestedVideoTable: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    

    var defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
    
    var dataTask = URLSessionDataTask()
    
    lazy var downloadsSession: Foundation.URLSession = {
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
        
        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        return session
        
    }()
    

    var myVideos = [Video]()
    
    var recommendedVideos = [Video]()
    
    var video: Video?
    
    var parentView : VideoViewController!
    
    override func viewDidLoad() {

        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (recommendedVideos.count == 0) {
            
            if(category.videoType == VideoType.youtube) {
                
            
            recommendedVideos = search.getYouTubeVideos(playlist: (categorySection?.sectionPlaylist!)!)!
                
                
            } else if(categorySection?.sectionType == SectionType.upcomingEventList){
                
                
                let upcomingEventsFeed = UpcomingEventsFeed()
                
                upcomingEvents = upcomingEventsFeed.getUpcomingEventUpdate(category: category)!
                
         
                var videos = [Video]()

                videos =  upcomingEventsFeed.getUpcomingEventVideos(events: upcomingEvents)
                

                recommendedVideos = videos
                
                
            } else {
            
                
          
            
      recommendedVideos = search.search((categorySection?.searchID!)! )
            }
        
        }
        myVideos = recommendedVideos
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func releaseDateOrder() {
        

        let sortedVideos: [Video] = myVideos.sorted { $0.eventDate! > $1.eventDate! }
        
        
            recommendedVideos = sortedVideos
    
        myVideos = sortedVideos
        
        self.tableView.reloadData()
        
        
        
    }
    
    
    func nameOrder() {

        let sortedVideos: [Video] = myVideos.sorted { $0.title! < $1.title! }
        
        recommendedVideos = sortedVideos
        
          myVideos = sortedVideos

        self.tableView.reloadData()
        
        
    }
    

    
    func removeDuplicateVideo() {
        
        var count = 0
        
        for vid in recommendedVideos {
            
            
            
            
            if(video?.title == vid.title) {
                
                recommendedVideos.remove(at: count)
                
                tableView.reloadData()
                
            }
            
            count += 1
            
            
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "ShowDetail" {
            
            
            
            let videoDetailViewController = segue.destination as! VideoViewController
            
            
            // Get the cell that generated this segue.
            
            if let selectedVideoCell = sender as? MainVideoCell {
                
                
                
                let indexPath = tableView.indexPath(for: selectedVideoCell)!
                
                
                let selectedVideo = myVideos[indexPath.row]
                
                videoDetailViewController.video = selectedVideo
                

                
                if(selectedVideo.fileName == 1) {
                    
                    
                    let sections = Category(categoryFactory: CategoryFactory(factorySettings: teens()))
                    
                    
                    
                    sections.createListing()
                  
  
                    
                } else {
                    
                    
 
                      suggestedSearch = category.sections[selectedSection]
                    
                    
                    
                    videoDetailViewController.setCategory(category: category)
                    
                    
                    
                }
                

  
                videoDetailViewController.setDefaultSession(defaultSession: &defaultSession)
                
                videoDetailViewController.setDataTask(dataTask: &dataTask)
                
                
                videoDetailViewController.setDownloadsSession(downloadsSession: &downloadsSession)
                
            }
            
        }
            
    
        
    }
    
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainVideoCell", for: indexPath) as? MainVideoCell
        
        cell?.titleLabel?.text = recommendedVideos[indexPath.row].title
        
        cell?.dateLabel?.text = recommendedVideos[indexPath.row].eventDate!.convertDateToString()
        
        cell?.thumbnailView.image = recommendedVideos[indexPath.row].thumbnail
        
        cell?.thumbnailView.setRadius(radius: imageRadius)
        
        DispatchQueue.global(qos: .userInitiated).async  {  //generate thumbnail in background
            
            if(self.recommendedVideos[indexPath.row].fileName != nil ) {
                
                if(self.recommendedVideos[indexPath.row].hasThumbnailUrl() == true) {
                    
                  self.recommendedVideos[indexPath.row].thumbnail = search.getThumbnail(url:  self.recommendedVideos[indexPath.row].thumbnailUrl!)
       
                } else {
             
            let thumbnail: UIImage? = search.getThumbnail(id: self.recommendedVideos[indexPath.row].fileName!)
                
                if(thumbnail != nil ) {
                    
                     self.recommendedVideos[indexPath.row].thumbnail = thumbnail
                    
                } else {
                    
                self.recommendedVideos[indexPath.row].thumbnail = #imageLiteral(resourceName: "defaultPhoto")
                    
            }
        
                }
                
            } else {
                
                 self.recommendedVideos[indexPath.row].thumbnail = #imageLiteral(resourceName: "defaultPhoto")
                
            }
            
            DispatchQueue.main.async {
                
                cell?.thumbnailView.image =  self.recommendedVideos[indexPath.row].thumbnail
                
                
                if(self.categorySection?.sectionType == SectionType.upcomingEventList) {
                    
                    
                    cell?.thumbnailView.image = cell?.thumbnailView.image?.cropBottomImage(image: (cell?.thumbnailView.image!)!)
                    
                }

            }
            
        }
        return cell!
        
        
    }
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recommendedVideos.count
    }
    
    

    
    
    
}


extension CategoryTableViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        if let downloadUrl = downloadTask.originalRequest?.url?.absoluteString,
            
            let download = GlobalVariables.sharedManager.activeDownloads[downloadUrl] {
          
            
            download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        
          //  let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: ByteCountFormatter.CountStyle.binary)
            
            
            
           
            
        }
        
    }
    
}
extension CategoryTableViewController: UIToolbarDelegate {
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        
        return .topAttached
        
    }
    
}





