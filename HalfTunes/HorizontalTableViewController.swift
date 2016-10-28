//
//  HorizontalTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/21/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class HorizontalTableViewController: UITableViewController {
    
    
 
    var storedOffsets = [Int: CGFloat]()
    
    var search = VideoSearch()
    
   
   
    

    var videos = [[Video]]()
    
  
    
    var sectionTitles = [String]()
    
    
    
    
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
        
        videos.append(search.trimVideos(videoArray: search.getRecent(), numberToReturn: 10))
        
      sectionTitles.append("Recent Videos")
   
        
     videos.append(search.trimVideos(videoArray: search.getHockeyLimited(), numberToReturn: 10))
        
        sectionTitles.append("Recent Baseball")
        
        
  
        
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
            
            
            
            
            
        } else {
            
            
             self.tableView.rowHeight = 160.0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? HorizontalTableViewCell
         cell!.sectionLabel.text = sectionTitles[indexPath.section]
            
            
            return cell!
        
        }
            
        
   
    }
    

    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HorizontalTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
        tableViewCell.collectionViewOffset = storedOffsets[(indexPath as NSIndexPath).row] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HorizontalTableViewCell else { return }
        
        storedOffsets[(indexPath as NSIndexPath).row] = tableViewCell.collectionViewOffset
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
        
        
    }
    
    
    
}

extension HorizontalTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        return videos[collectionView.tag].count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
  if collectionView.tag == 1  {
            
            

            
            
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCollectionCell", for: indexPath)
            
            // cell.backgroundColor = model[collectionView.tag][(indexPath as NSIndexPath).item]
            var cells : ThumbnailButtonCell
            
            cells = cell as! ThumbnailButtonCell
            
            
            if ((videos[collectionView.tag][indexPath.item].fileName) != nil) {
                
                cells.thumbnail.image = search.getThumbnail(id: (videos[collectionView.tag][indexPath.item].fileName!))
                
                cells.thumbnail.setRadius(radius: 4)
                
    
            return cell
            
            
            
            
            
        }
    
    
    
    
    
        }
        
    
        
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionCell", for: indexPath)
            
            // cell.backgroundColor = model[collectionView.tag][(indexPath as NSIndexPath).item]
            var cells : HorizontalCollectionViewCell
            
            cells = cell as! HorizontalCollectionViewCell
            
            
            if ((videos[collectionView.tag][indexPath.item].fileName) != nil) {
                
                cells.thumbnail.image = search.getThumbnail(id: (videos[collectionView.tag][indexPath.item].fileName!))
                
                cells.thumbnail.setRadius(radius: 4)
                
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
    










