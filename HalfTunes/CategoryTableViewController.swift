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
    
    
    var search = VideoSearch()
    
    var recommendedVideos = [Video]()
    
    var video: Video?
    
    var parentView : VideoViewController!
    
    override func viewDidLoad() {
        
       
        
        
  
        
        super.viewDidLoad()
        
        
  
        
  
        
    //    recommendedVideos = search.search(category.rawValue )
        
        
        
     //   myVideos = recommendedVideos
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (recommendedVideos.count == 0) {
            
            if(category.videoType == VideoType.youtube) {
                
            
            recommendedVideos = search.getYouTubeVideos(playlist: (categorySection?.sectionPlaylist!)!)!
                
                
            } else {
             print("calling serach from categorytable view will appear")
            
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
        
  //  let sortedMovies = myVideos.sort { $0.title < $1.title }
        
        
        
        
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
    
    // MARK: - Table view data source
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
                    
                    
                    var sections = Category(categoryFactory: CategoryFactory(factorySettings: teenFactorySettings()))
                    
                    
                    
                    sections.createListing()
                  
                    
                   // videoDetailViewController.setCategory(category: sections)
                    
                    
                    
                } else {
                    
                    
                 
                    

                    
                      suggestedSearch = category.sections[selectedSection]
                    
                    
                    
                    videoDetailViewController.setCategory(category: category)
                    
                    
                    
                }
                
                
                //    videoDetailViewController.setActiveDownloads(downloads: &parentView.downloads)
                
                
                videoDetailViewController.setDefaultSession(defaultSession: &defaultSession)
                
                videoDetailViewController.setDataTask(dataTask: &dataTask)
                
                
                videoDetailViewController.setDownloadsSession(downloadsSession: &downloadsSession)
                
            }
            
        }
            
        else if segue.identifier == "AddItem" {
            
            print("Adding new video.")
            
        }
        
    }
    
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainVideoCell", for: indexPath) as? MainVideoCell
        
        
        cell?.titleLabel?.text = recommendedVideos[indexPath.row].title
        
        
        cell?.dateLabel?.text = convertDateToString(date: recommendedVideos[indexPath.row].eventDate!)
        
        cell?.thumbnailView.image = recommendedVideos[indexPath.row].thumbnail
        
        cell?.thumbnailView.setRadius(radius: imageRadius)
        
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.low).async {  //generate thumbnail in bacground
            
         
                
            if(self.recommendedVideos[indexPath.row].fileName != nil ) {
                
                if(self.recommendedVideos[indexPath.row].hasThumbnailUrl() == true) {
                    
                  self.recommendedVideos[indexPath.row].thumbnail = self.search.getThumbnail(url:  self.recommendedVideos[indexPath.row].thumbnailUrl!)
                    
                   // self.thumbnailView.image = video.thumbnail
                    
                    
                    
                } else {
             
            var thumbnail: UIImage? = self.search.getThumbnail(id: self.recommendedVideos[indexPath.row].fileName!)
                
                
                
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


extension CategoryTableViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        if let downloadUrl = downloadTask.originalRequest?.url?.absoluteString,
            
            let download = GlobalVariables.sharedManager.activeDownloads[downloadUrl] {
            // 2
            
            download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            // 3
            let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: ByteCountFormatter.CountStyle.binary)
            // 4
            
            
           
            
        }
        
    }
    
}
extension CategoryTableViewController: UIToolbarDelegate {
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}





