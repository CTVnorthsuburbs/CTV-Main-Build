//
//  SuggestedVideosTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/20/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class SuggestedVideosTableViewController: UITableViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addVideoButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet var suggestedVideoTable: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var defaultSession : Foundation.URLSession? = nil
    
    var dataTask: URLSessionDataTask?
    
    var downloadsSession: Foundation.URLSession?
    
    var myVideos = [Video]()
    
    var section: Int?
    
    
    var search = VideoSearch()
    
    var recommendedVideos = [Video]()
    
    var video: Video?
    
    var parentView : VideoViewController!
    
    var currentCategory: Category?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
    }
    func setCategory(category: Category) {
        
        
        currentCategory = category
        
    }
    
    func setCategory(category: Category, section: Int) {
        
        
        currentCategory = category
        
        self.section = section
        
    }
    
    func setVideo(video: Video) {
        
      
            
  
            
        if( currentCategory?.videoType == VideoType.youtube) {
            
            
              if(self.section == nil) {
                print("the first")
           recommendedVideos =  search.getYouTubeVideos(playlist: (currentCategory?.sections[0].sectionPlaylist!)!)!
            
            
            recommendedVideos = search.trimVideos(videoArray: recommendedVideos, numberToReturn: 10)
            
            
            
            } else {
                
                  print("the second")
                
                recommendedVideos =  search.getYouTubeVideos(playlist: category.sections[self.section!].sectionPlaylist!)!
                
                
                recommendedVideos = search.trimVideos(videoArray: recommendedVideos, numberToReturn: 10)
                
                
            }
            
            
        } else {
        var searchID = suggestedSearch?.searchID
        
        
        if (searchID != nil && searchID != 1 && searchID != 2) {
            
            var results = search.search(searchID!)
            
            results = search.trimVideos(videoArray: results, numberToReturn: 10)
            
            recommendedVideos = results
            
          
        } else {
            
             recommendedVideos = search.getRecentLimited()
        }
        }
        
        
        
        myVideos = recommendedVideos
        
        self.video = video
        
        if( removeDuplicateVideo(video: video, videoList: recommendedVideos) ) {
            
            tableView.reloadData()
        }
       
            
        
        
        
        
    }
    
    
    func removeDuplicateVideo(video: Video, videoList: [Video]) -> Bool {
        
        var videoList = videoList
        
        var count = 0
        
        for vid in videoList {
            
            if(video.title == vid.title) {
                
              
                
                videoList.remove(at: count)
                
                self.recommendedVideos = videoList
                
                self.myVideos  = videoList
                
                return true
            }
            
            count += 1
            
        }
        
        return false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            
            let videoDetailViewController = segue.destination as! VideoViewController
            
            
            // Get the cell that generated this segue.
            
            if let selectedVideoCell = sender as? MainVideoCell {
                
                
                
                let indexPath = tableView.indexPath(for: selectedVideoCell)!
                
                
                let selectedVideo = myVideos[indexPath.row]
                
                videoDetailViewController.video = selectedVideo
                
                //    videoDetailViewController.setActiveDownloads(downloads: &parentView.downloads)
                
                
                
                
                
                
                
                suggestedSearch = category.sections[indexPath.section]
                
             
                
                
                
                
                selectedSection = indexPath.section
                
                
            
                
                
                
                
                
                if(selectedVideo.fileName == 1) {
                    
                    
                    var sections = Category(categoryFactory: CategoryFactory(factorySettings: teenFactorySettings()))
                    
                    
                    
                    sections.createListing()
                    
                    
                    videoDetailViewController.setCategory(category: sections)
                    
                    
                    
                } 
                
                
                
                
                
                
                
                videoDetailViewController.setDefaultSession(defaultSession: &parentView.defaultSession!)
                
                videoDetailViewController.setDataTask(dataTask: &parentView.dataTask!)
                
                
                videoDetailViewController.setDownloadsSession(downloadsSession: &parentView.downloadsSession!)
                
            }
            
        }
            
        else if segue.identifier == "AddItem" {
            
            print("Adding new video.")
            
        }
        
    }
    
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as? MainVideoCell
        
        video = recommendedVideos[indexPath.row]
        
        
        cell?.titleLabel?.text = recommendedVideos[indexPath.row].title
        
        
        cell?.dateLabel?.text = convertDateToString(date: recommendedVideos[indexPath.row].eventDate!)
        
        cell?.thumbnailView.image = recommendedVideos[indexPath.row].thumbnail
        
        cell?.thumbnailView.setRadius(radius: imageRadius)
        
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.low).async {  //generate thumbnail in bacground
            
            do {
                
                
                
                
                if( self.recommendedVideos[indexPath.row].hasThumbnailUrl()) {
                    
                    
                    
                    self.recommendedVideos[indexPath.row].thumbnail =  self.search.getThumbnail(url: self.recommendedVideos[indexPath.row].thumbnailUrl! )

                   
                    
                    
                } else {
                    
                    
                    
                    
                   self.recommendedVideos[indexPath.row].generateThumbnailUrl()
                    
                  
                    
                    if( self.recommendedVideos[indexPath.row].thumbnailUrl != nil) {
                    
                    self.recommendedVideos[indexPath.row].thumbnail =  self.search.getThumbnail(url: self.recommendedVideos[indexPath.row].thumbnailUrl! )
                    }
                    
                }
                
                
                //  self.recommendedVideos[indexPath.row].generateThumbnail()
                
                
                
                
                
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
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recommendedVideos.count
    }
    
    
    @IBAction func addVideoPressed(_ sender: AnyObject) {
        
        
        parentView.addVideo(self.addVideoButton)
        
    }
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        
        
        parentView.cancelTapped(self.cancelButton)
        
    }
    
    
    
}
