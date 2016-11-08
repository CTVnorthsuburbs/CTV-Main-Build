//
//  HorizontalTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/21/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class HorizontalTableViewController: UITableViewController {
    
    
 
   // var storedOffsets = [Int: CGFloat]()
    
    var search = VideoSearch()
    
   
   
    

    var videos = [[Video]]()
    
    var thumbnailButtons : [[ThumbnailButton]] = [[],[]]
    
    
    
    
    
  
    
    var sectionTitles = [String]()
    
    
    var sectionSearchCategories = [Category]()
    
    
    
    
    
    var defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
    
    var dataTask = URLSessionDataTask()
    
    lazy var downloadsSession: Foundation.URLSession = {
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
        
        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        return session
        
    }()
    
    
    
    @IBOutlet weak var tableCollection: UICollectionView!
    
    override func viewDidLoad() {
        
 
        
        
        
        
        videos.append(search.getRecentLimited())
        
        sectionTitles.append("Featured Events")
        
        sectionSearchCategories.append(Category.recent)
        
        
        
        videos.append(search.trimVideos(videoArray: search.getRecent(), numberToReturn: 10))
        
      sectionTitles.append("Recent Videos")
    
        sectionSearchCategories.append(Category.recent)
   
        
        
     videos.append(search.trimVideos(videoArray: search.search(67200) , numberToReturn: 10))
        
        sectionTitles.append("Recent Baseball")
        
        sectionSearchCategories.append(Category.baseball)
        
        
        
         sectionTitles.append("Browse by Sport")
        
        
        
        
        videos.append(search.trimVideos(videoArray: search.getNSB(), numberToReturn: 10))
        
        sectionTitles.append("Local News")
        
        sectionSearchCategories.append(Category.nsb)
        
        
        
        videos.append(search.trimVideos(videoArray: search.getBasketball(), numberToReturn: 10))
        
        sectionTitles.append("Basketball Season")
        
        sectionSearchCategories.append(Category.basketball)
        
        
        
        thumbnailButtons[0].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "categories"), category: Category.hockey))
        
        
        
        thumbnailButtons[0].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "schedule"), category: Category.hockey))
        
        
         thumbnailButtons[0].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "shows"), category: Category.hockey))
        
         thumbnailButtons[0].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "events"), category: Category.hockey))
        
        
        
        
        
        
        
  
          thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "basketball"), category: Category.hockey))
        
        
        thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "volleyball"), category: Category.hockey))
        
        
        thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "hockey"), category: Category.hockey))
        
        
        thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "swimming"), category: Category.hockey))
        
        thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "football"), category: Category.hockey))
        
         thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "gymnastics"), category: Category.hockey))
        
         thumbnailButtons[1].append(ThumbnailButton(thumbnail: #imageLiteral(resourceName: "baseball"), category: Category.hockey))

        
        
        
        
        
        videos.append(search.trimVideos(videoArray: search.search(67318), numberToReturn: 10))
        
        sectionTitles.append("Concerts")
        
        sectionSearchCategories.append(Category.concerts)
        
        
        
        
        
        
        
 // videos.append(search.trimVideos(videoArray: search.getBasketball(), numberToReturn: 10))
        
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        

        return sectionTitles[section]
        
        
    }
    
    */
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return videos.count
        
        
    }
    
    
    


 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // return videos.count
        
        
     // return videos[section].count
        
        return 1
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> HorizontalTableViewCell {
        
        
     
     
        
        if (indexPath.section == 1) {
            
        
            
            self.tableView.rowHeight = 100.0
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbnailCell", for: indexPath) as? HorizontalTableViewCell
           // cell!.sectionLabel.text = sectionTitles[indexPath.section]
            
            
            return cell!
            
            
            
            
            
        }
        
        if (indexPath.section == 3) {
            
            
            
            self.tableView.rowHeight = 120.0
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbnailTitleCell", for: indexPath) as? HorizontalTableViewCell
             cell!.sectionLabel.text = sectionTitles[indexPath.section]
            
            
            return cell!
            
            
            
            
            
            
            
        }
        
        else {
            
            
             self.tableView.rowHeight = 165.0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? HorizontalTableViewCell
         cell!.sectionLabel.text = sectionTitles[indexPath.section]
            

         
 
            return cell!
        
        }
            
        
   
    }
    

    
    
    
    
 
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HorizontalTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
       
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HorizontalTableViewCell else { return }
        
       
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
      
        
        
        if segue.identifier == "ShowDetail" {
            if let collectionCell: HorizontalCollectionViewCell = sender as? HorizontalCollectionViewCell {
                if let collectionView: UICollectionView = collectionCell.superview as? UICollectionView {
                    if let destination = segue.destination as? VideoViewController {
                        
                        
                        
                        
                        let indexPath = collectionView.indexPath(for: collectionCell)!
                        
                        
                        let selectedVideo = videos[collectionView.tag][indexPath.row]
                        
                        
                        
                        // Pass some data to YourViewController
                        // collectionView.tag will give your selected tableView index
                        
                        
                        destination.video = selectedVideo
                        
                        
                        
                        destination.setDefaultSession(defaultSession: &defaultSession)
                        
                        destination.setDataTask(dataTask: &dataTask)
                        
                        
                        destination.setDownloadsSession(downloadsSession: &downloadsSession)
                        
                        
                        
                    }
                }
            }
            
        }
        
        
        if segue.identifier == "seeAll" {
            

            if let destination = segue.destination as? CategoryViewController {
                
           
                let indexPath : IndexPath
                if let button = sender as? UIButton {
                    let cell = button.superview?.superview as! UITableViewCell
                    indexPath = self.tableView.indexPath(for: cell)!
                    
                    
                      
                    
                 
                    
                    destination.title = sectionTitles[indexPath.section]
                    
                    destination.category = sectionSearchCategories[indexPath.section]
                    
                    
                }
                
                
            
                
                
                
                
                
            
            }
        
        
        }
    }
}

    
    


extension HorizontalTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if(collectionView.tag == 1) {
            
            
            return thumbnailButtons[0].count
        }
        
        
        if(collectionView.tag == 3) {
            
            
            return thumbnailButtons[1].count
        }
        
        
        
        
        
        return videos[collectionView.tag].count
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
  if (collectionView.tag == 1)  {
            

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCollectionCell", for: indexPath)
            
            // cell.backgroundColor = model[collectionView.tag][(indexPath as NSIndexPath).item]
            var cells : ThumbnailButtonCell
            
            cells = cell as! ThumbnailButtonCell
  
                     cells.thumbnail.image = thumbnailButtons[0][indexPath.row].thumbnail
                    
                      cells.thumbnail.setRadius(radius: imageRadius)
                    
                    
                        return cells
 
               // cells.thumbnail.setRadius(radius: 4)
                
    
           // return cell
   
        }
        
        if (collectionView.tag == 3)  {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCollectionCell", for: indexPath)
            
            // cell.backgroundColor = model[collectionView.tag][(indexPath as NSIndexPath).item]
            var cells : ThumbnailButtonCell
            
            cells = cell as! ThumbnailButtonCell
            
            cells.thumbnail.image = thumbnailButtons[1][indexPath.row].thumbnail
            
            cells.thumbnail.setRadius(radius: imageRadius)
            
            
            return cells
            
            // cells.thumbnail.setRadius(radius: 4)
            
            
            // return cell
            
        }
        
        
        
    
        
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionCell", for: indexPath)
            
            // cell.backgroundColor = model[collectionView.tag][(indexPath as NSIndexPath).item]
            var cells : HorizontalCollectionViewCell
            
            cells = cell as! HorizontalCollectionViewCell
            
            
            if ((videos[collectionView.tag][indexPath.item].fileName) != nil) {
                
                cells.thumbnail.image = search.getThumbnail(id: (videos[collectionView.tag][indexPath.item].fileName!))
                
                cells.thumbnail.setRadius(radius: imageRadius)
                
                cells.titleLabel.text = videos[collectionView.tag][indexPath.item].title
                
                cells.dateLabel.text = convertDateToString(date: videos[collectionView.tag][indexPath.item].eventDate!)
                
                
           
    }
    
            
            return cell
            
        
        
     
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
        
        
        
        
    }
    
    
    
    

    

}





extension UIImage{
    
    func alpha(value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}

extension HorizontalTableViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
               }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        if let downloadUrl = downloadTask.originalRequest?.url?.absoluteString,
            
            let download = GlobalVariables.sharedManager.activeDownloads[downloadUrl] {
            // 2
            
            download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            // 3
            let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: ByteCountFormatter.CountStyle.binary)
            // 4
            
            
            /*
            if let videoIndex = videoIndexForDownloadTask(downloadTask), let videoCell = tableView.cellForRow(at: IndexPath(row: videoIndex, section: 0)) as? VideoCell {
                
                DispatchQueue.main.async(execute: {
             
                    
                    
                    videoCell.progressView.progress = download.progress
                    
                    var temp =  GlobalVariables.sharedManager.getDownload(downloadUrl: downloadUrl)
                    
                    temp?.progress = download.progress
                    
                    
                    
                    
                    
                })
                
            }
            */
        }
        
    }
    










