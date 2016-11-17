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
    
    var currentCategory: Category?
    
    
    
    
    var videos : [[Video?]]  = [[Video?]]()
    
 //   var thumbnailButtons : [[ThumbnailButton]] = [[],[]]
    
    
    
    
    
    
    
    var sectionTitles = [String]()
    
    
   var sectionSearchCategories = [CategorySearches]()
    
    
    
    
    
    var defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
    
    var dataTask = URLSessionDataTask()
    
    lazy var downloadsSession: Foundation.URLSession = {
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
        
        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        return session
        
    }()
    
    
    
    @IBOutlet weak var tableCollection: UICollectionView!
    
 
    
    override func viewDidLoad() {
        
 

        
     /*

        category.createListing()
        
        
        
        var index = 0
        
        
        
        
        while (index < category.sections.count) {
            
            if(category.sections[index].searchID != nil) {
            
            videos.append(search.search(category.sections[index].searchID!))
            
           
            
            
            } else {
                
                
                videos.append([nil])
                
            
                
                
            }
            
            
            index = index + 1
            
            
            
            
            
        }
        
        
   
        */
        
        
      //  self.currentCategory = category
     //   category.createListing()
        
        
     //   videos.removeAll()
        
        /*
        var index = 0
        
        
        
        
        while (index < category.sections.count) {
            
            if(category.sections[index].searchID != nil) {
                
                
                if(category.sections[index].getDisplayCount() == nil) {
                    
                    videos.append(search.search(category.sections[index].searchID!))
                    
                } else {
                    
                    
                    
                    var vids = search.search(category.sections[index].searchID!)
                    
                    
                    var trimmedVids = search.trimVideos(videoArray: vids, numberToReturn: category.sections[index].getDisplayCount()!)
                    
                    videos.append(trimmedVids)
                    
                    
                    
                }
                
                
            } else {
                
                
                videos.append([nil])
                
                
                
                
            }
            
            
            index = index + 1
            
            
 
            
            
        }
     //   self.tableView.reloadData()
        
     
      //  self.tableView.reloadData()
        
       
     */
        
        
        
        // videos.append(search.trimVideos(videoArray: search.getBasketball(), numberToReturn: 10))
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        
        
  
        
        
        if(currentCategory?.categoryTitle != category.categoryTitle ) {
        
        category.createListing()
        currentCategory = category
        
        videos.removeAll()
        
        var index = 0
        
        
        
        
        while (index < category.sections.count) {
            
            if(category.sections[index].searchID != nil) {
                
                
                if(category.sections[index].getDisplayCount() == nil) {
                    
                    
                    
                
                videos.append(search.search(category.sections[index].searchID!))
                
                } else {
                    
                    
                   
                    var vids = search.search(category.sections[index].searchID!)
                    
                    
                    var trimmedVids = search.trimVideos(videoArray: vids, numberToReturn: category.sections[index].getDisplayCount()!)
                    
                videos.append(trimmedVids)
                    
               
                    
                }
                
                
            } else {
                
                
                videos.append([nil])
                
                
                
                
            }
            
            
            index = index + 1
            
            
            
            
            
        }
        
        self.tableView.reloadData()
            
            self.changeTableSize()
            
            
            
        }

        
      
        
         
  
   
    }
    
 


    
    func changeTableSize() {
        
        
        var tableSize: CGFloat = 0
        
        for section in (currentCategory?.sections)! {
            
            
            switch section.sectionType {
                
            case .videoList:
                
                tableSize = tableSize + CGFloat(165)
                
            case .buttonNoTitle:
                
                tableSize = tableSize + CGFloat(100)
                
            case .buttonWithTitle:
                
                tableSize = tableSize + CGFloat(120)
                
            default:
                
                tableSize = tableSize + CGFloat(165)
                
            }
            
            
            
        }
        
 
        
        
        
  
        
        //  var frame =  CGRect(x: 0, y: 0, width: (parent?.view.frame.size.width)!, height: tableSize)
        
        //     print("frame: \(frame.height)")
        
        
        var parentVC = self.parent as! MainTableViewController
        
        
        parentVC.changeSize(height: Int(tableSize))
        
        self.tableView.frame.size.height = tableSize
        
        self.tableView.reloadData()
        
      
        
        //   self.parent?.view.frame = frame
        
        
        //  self.view.layoutIfNeeded()
        
  
        
    }
    
    
    /*
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     
     
     return sectionTitles[section]
     
     
     }
     
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        
        //   return videos.count
        
        return category.sections.count
        
        
    }
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // return videos.count
        
        
        // return videos[section].count
        
        return 1
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> HorizontalTableViewCell {
 
        var section = category.getSection(row: indexPath.section)
        
        if (section.sectionType == SectionType.slider) {
            
            
            
            
            self.tableView.rowHeight = 165.0
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? HorizontalTableViewCell
            cell!.sectionLabel.text = section.sectionTitle
            
            
            return cell!
            
            
            
        }
        
        
        if (section.sectionType == SectionType.videoList) {
            
            
            
            
            self.tableView.rowHeight = 165.0
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? HorizontalTableViewCell
            cell!.sectionLabel.text = section.sectionTitle
            
            
         
            
            return cell!
            
            
            
        }
        
        if (section.sectionType == SectionType.buttonWithTitle) {
            
            
            
            
            self.tableView.rowHeight = 120.0
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbnailTitleCell", for: indexPath) as? HorizontalTableViewCell
            cell!.sectionLabel.text = section.sectionTitle
            
            
            return cell!
       
            
        }
        
        
        if (section.sectionType == SectionType.buttonNoTitle) {
            
            
            
            
            
            self.tableView.rowHeight = 100.0
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbnailCell", for: indexPath) as? HorizontalTableViewCell
            // cell!.sectionLabel.text = sectionTitles[indexPath.section]
            
            
            return cell!
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        self.tableView.rowHeight = 165.0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? HorizontalTableViewCell
        cell!.sectionLabel.text = section.sectionTitle
        
        
        
        
        return cell!
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HorizontalTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
        
        tableViewCell.reloadCell()
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
                    
                    
                    
                    
                    
                    
                   //destination.title = sectionTitles[indexPath.section]
                    
                    
                    destination.title = category.sections[indexPath.section].sectionTitle
                    
                    destination.categorySection = category.sections[indexPath.section]

                    
                    
                }
                
                
                
                
                
                
                
                
                
            }
            
            
        }
    }
}





extension HorizontalTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        if(category.sections[collectionView.tag].sectionType == SectionType.videoList) {
            
   
            
           
        
        return videos[collectionView.tag].count
                
            
            
        } else if(category.sections[collectionView.tag].sectionType == SectionType.buttonWithTitle || category.sections[collectionView.tag].sectionType == SectionType.buttonNoTitle) {
            
            
            return category.sections[collectionView.tag].buttons!.count
            
            
            
        }
        
        return videos[collectionView.tag].count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
         
         
                 if(category.sections[collectionView.tag].sectionType == SectionType.buttonWithTitle || category.sections[collectionView.tag].sectionType == SectionType.buttonNoTitle) {
                    
                    
         
         
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCollectionCell", for: indexPath)
         
         // cell.backgroundColor = model[collectionView.tag][(indexPath as NSIndexPath).item]
         var cells : ThumbnailButtonCell
         
         cells = cell as! ThumbnailButtonCell
         
        // cells.thumbnail.image = thumbnailButtons[0][indexPath.row].thumbnail
                    
                    
        cells.thumbnail.image = category.sections[collectionView.tag].buttons?[indexPath.row].image
         
         cells.thumbnail.setRadius(radius: imageRadius)
         
         
         return cells
         
         // cells.thumbnail.setRadius(radius: 4)
         
         
         // return cell
         
         }
        
        
        /*
         
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
         
         
         
         */
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionCell", for: indexPath)
        
        // cell.backgroundColor = model[collectionView.tag][(indexPath as NSIndexPath).item]
        var cells : HorizontalCollectionViewCell
        
        cells = cell as! HorizontalCollectionViewCell
        
        
        
        /*
        if ((videos[collectionView.tag][indexPath.item].fileName) != nil) {
            
            cells.thumbnail.image = search.getThumbnail(id: (videos[collectionView.tag][indexPath.item].fileName!))
            
            cells.thumbnail.setRadius(radius: imageRadius)
            
            cells.titleLabel.text = videos[collectionView.tag][indexPath.item].title
            
            cells.dateLabel.text = convertDateToString(date: videos[collectionView.tag][indexPath.item].eventDate!)
        }
 
 */
        
        if(category.sections[collectionView.tag].sectionType == SectionType.videoList) {
        
        var videos = search.search(category.sections[collectionView.tag].searchID!)
        
        
        
        if (videos[indexPath.item].fileName != nil) {
            
            
            
            
           
                    
                    cells.thumbnail.image = self.search.getThumbnail(id: (videos[indexPath.item].fileName)!)
                    
                    cells.thumbnail.setRadius(radius: imageRadius)
                    
                    
                    cells.titleLabel.text = videos[indexPath.item].title
                    
                    cells.dateLabel.text = convertDateToString(date: videos[indexPath.item].eventDate!)
                    
                  

        
        
        }
        }
        
        return cell
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
        if(collectionView.tag == 1 && indexPath.row == 0) {
            
            let viewController:CategoriesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Category") as! CategoriesViewController
            // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
            
            var parent = self.parent as! MainTableViewController
            
            
            viewController.category = parent.currentCategory
            
            
            self.present(viewController, animated: true, completion: nil)
        }
        
        
        
        
        
        
        
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











