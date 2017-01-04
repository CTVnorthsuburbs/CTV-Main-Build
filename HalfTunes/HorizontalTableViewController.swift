//
//  HorizontalTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/21/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit
 var selectedSection = 1
class HorizontalTableViewController: UITableViewController {
    
    
    var listOfVideos = [Int: [Video]]()
    // var storedOffsets = [Int: CGFloat]()
    
    var search = VideoSearch()
    
  //  var currentCategory: Category?
    
   

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

    
        
    }

    override func viewWillAppear(_ animated: Bool) {
        

    
       
            
            
         
            
       //     currentCategory = category
            
            
            videos.removeAll()
            if(category.sections.count == 0) {
                
                
        category.createListing()
                
                
                
            }
   //    currentCategory = category
        
            
            print(videos.count)
            
            for vid in videos {
                
                
                
                print(vid.count)
                
                
            }
            
            if(videos.count == 0) {
        
            
            
         
        var index = 0
  
        while (index < category.sections.count) {
            
            
            
            
            
            if(category.sections[index].searchID != nil) {
                
                
                
                if(category.videoType == VideoType.cablecast) {
                    
                    
                    
                if(category.sections[index].getDisplayCount() == nil) {
                    
                    
                    
                
                videos.append(search.search(category.sections[index].searchID!))
                
                } else {
                    
                    
                   
                    var vids = search.search(category.sections[index].searchID!)
                    
                    
                    var trimmedVids = search.trimVideos(videoArray: vids, numberToReturn: category.sections[index].getDisplayCount()!)
                    
                videos.append(trimmedVids)
                    
               
                    
                }
                
             
                } else if(category.videoType == VideoType.youtube) {
                    
                    
                    
                    if(category.sections[index].getDisplayCount() == nil) {
                        
                        
                        print("display count = nil")
                        
                       // videos.append(search.search(category.sections[index].searchID!))
                        
                        
                        videos.append(search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)!)
                        
                        
                        
                        
                        
                    } else {
                        
                        print("display count = \(category.sections[index].getDisplayCount())")
                        
                        var vids = search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)
                        print("playlist \(category.sections[index].sectionPlaylist!) ")
                        
                        var trimmedVids = search.trimVideos(videoArray: vids!, numberToReturn: category.sections[index].getDisplayCount()!)
                        
                        videos.append(trimmedVids)
                        
                        
                        
                    }
                    

                    
                    
                    
                    
                    
                }
                    
                    
                    
                    
                    
                    
                
            
            
                
                
                
            } else {
                
                
                videos.append([nil])
                

            }
            
            
            index = index + 1
 
            
            
            
                }
        }
        
        self.tableView.reloadData()
            
            self.changeTableSize()
            
            
            
        
        
   

    }

    
    func changeTableSize() {
        
        
        var tableSize: CGFloat = 0
        
        for section in (category.sections) {
            
            
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
            
            if(section.displayCount == nil){
                
                section.displayCount = 15
                
            }
            if(section.displayCount != nil) {
                
                if(section.displayCount! >  videos[indexPath.section].count) {
                
                    cell!.disableSeeAllButton()
                    //THIS IS WHERE SEE ALL CAN BE REMOVED
                    
                }
            }
            
            
            
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
                        
                       
                        
                        
                        
                        
                       suggestedSearch = category.sections[collectionView.tag]
                        
                        var selectedVideo = videos[collectionView.tag][indexPath.row]

                        
                        destination.video = selectedVideo
                        
                        
                        selectedSection = collectionView.tag
                        
                        
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
                    
                    selectedSection = indexPath.section
                    
                    print("THE SELECTED IS \(indexPath.section)")
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
            
            
            return category.sections[collectionView.tag].buttons.count
            
            
            
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
                  
                    
                    if (category.sections[collectionView.tag].buttons[indexPath.row]?.type == ButtonType.video) {
                        
                        
                        if(category.sections[collectionView.tag].buttons[indexPath.row]?.imageOverlay != nil) {
                        
                            
                         
                            
                             cells.textOverlay.text = category.sections[collectionView.tag].buttons[indexPath.row]?.imageOverlay
                            
                            
                                                    } else {
                            
                            
                            cells.textOverlay.text = nil
                        }
                        
                        
                        
                        
                 
                
          
                        
                        
                        
                        var videoID = self.search.searchForSingle( (category.sections[collectionView.tag].buttons[indexPath.row]?.videoID)!)
                        
                        
                        

                        var thumbnail =  self.search.getThumbnail(id: (videoID.first?.fileName)!)
                        
                 
                                
                                
                                cells.thumbnail.image = thumbnail
                                
                                cells.thumbnail.alpha = 0.5
                        
      
                        
                    } else {
                    
                    
                    
        cells.thumbnail.image = category.sections[collectionView.tag].buttons[indexPath.row]?.image
                        
                        
                        cells.textOverlay.text = nil
                        
                        cells.thumbnail.alpha = 1.0
                        
                    }
         
         cells.thumbnail.setRadius(radius: buttonRadius)
         
                    
                    
                 
         
         return cells
         
         // cells.thumbnail.setRadius(radius: 4)
         
         
         // return cell
         
         }
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionCell", for: indexPath)
        
        // cell.backgroundColor = model[collectionView.tag][(indexPath as NSIndexPath).item]
        var cells : HorizontalCollectionViewCell
        
        cells = cell as! HorizontalCollectionViewCell
        
      
        
        
        if(category.sections[collectionView.tag].sectionType == SectionType.videoList) {
            
            
            var videos = [Video]()
            
            
            
            
            
            
            
            
            
 
            
            
            
            if(category.videoType == VideoType.youtube) {
                
                
               
                
                
                if (listOfVideos.keys.contains(category.sections[collectionView.tag].searchID!)) {
                    
                    
                    videos = listOfVideos[category.sections[collectionView.tag].searchID!]!
                    
                    
                } else {
                    
                    listOfVideos[category.sections[collectionView.tag].searchID!] = search.getYouTubeVideos(playlist: category.sections[collectionView.tag].sectionPlaylist!)
                    
                    
                    videos = listOfVideos[category.sections[collectionView.tag].searchID!]!
                    
                    
                    
                }
              
                
                
                
            } else if(category.videoType == VideoType.cablecast) {
                
                
                
                
                
                
                if (listOfVideos.keys.contains(category.sections[collectionView.tag].searchID!)) {
                    
                    
                    videos = listOfVideos[category.sections[collectionView.tag].searchID!]!
                    
                    
                } else {
                    
                    listOfVideos[category.sections[collectionView.tag].searchID!] = search.search(category.sections[collectionView.tag].searchID!)
                    
                    
                    videos = listOfVideos[category.sections[collectionView.tag].searchID!]!
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            
            
            
      
            
       
        
     //  var videos = search.search(category.sections[collectionView.tag].searchID!)
        
            
            /*
            
           if(category.sections[collectionView.tag].displayCount != nil) {
            
            if(category.sections[collectionView.tag].displayCount! < videos.count) {
                
                
               //THIS IS WHERE SEE ALL CAN BE REMOVED
                
            }
            }
 
 
 
 */
        
        if (videos[indexPath.item].fileName != nil) {
            
           
                
                
            if( videos[indexPath.item].hasThumbnailUrl()) {
                
                
              
               
                
                   cells.thumbnail.image = self.search.getThumbnail(url: (videos[indexPath.item].thumbnailUrl)!)
                
                
            } else {
                
                
               
                
                videos[indexPath.item].generateThumbnailUrl()
                
          
                
                cells.thumbnail.image = self.search.getThumbnail(url: (videos[indexPath.item].thumbnailUrl)!)
                
                
                
            }
            
            
         
                
            
            
          
            
            
                    
                    cells.thumbnail.setRadius(radius: imageRadius)
                    
                    
                    cells.titleLabel.text = videos[indexPath.item].title
                    
                    cells.dateLabel.text = convertDateToString(date: videos[indexPath.item].eventDate!)
                    
                  

        
        
        } else {
            
            
            
    
            
            
            
            cells.thumbnail.image = #imageLiteral(resourceName: "placeholder-header")
            
            cells.thumbnail.setRadius(radius: imageRadius)
            
            
            cells.titleLabel.text = videos[indexPath.item].title
            
            cells.dateLabel.text = convertDateToString(date: videos[indexPath.item].eventDate!)
            
            
            
            }
        }
        
        return cell
        
    }
    
    func setCategory(newCategory: Category) {
        
        category = newCategory
        
        category = newCategory
        
        var parentVC = self.parent as! MainTableViewController
        
        
        
      //  parentVC.currentCategory = newCategory
        
        
        
        
        category.createListing()
      //  currentCategory = category
        
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
    
    
    
    
 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
       
        
        if(category.sections[collectionView.tag].sectionType == SectionType.buttonNoTitle ||  category.sections[collectionView.tag].sectionType == SectionType.buttonWithTitle) {
            
            var buttons = category.sections[collectionView.tag].buttons
           
         
            
            
            
            var button = buttons[indexPath.row]
            
            
            
            
            if(button?.type == ButtonType.category) {
                
               
              //  category = (button?.category)!
                
                
                
       
              //  previousCategory = category
                
               // featured = false
                
                
                
                
               //  let viewController = MainTableViewController(category: (button?.category)!)
                
                
            let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "mainTable2") as! MainTableViewController
              
             vc.setCategory(newCategory: (button?.category)!)
             //   currentCategory = button?.category!
                
               // self.navigationController?.pushViewController(vc, animated:true)
                
            
                
               self.navigationController?.show(vc, sender: self)
                
           
       
            }
            
            
            
            if(button?.type == ButtonType.page) {
                
                
                var page = button?.page
                
        
      
                
                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: page!)
                
                
                vc.title = button?.title
                
                
                self.navigationController?.pushViewController(vc, animated:true)
                
            }
            
            
            
            
            
            if(button?.type == ButtonType.webPage) {
                
                
                
               /*

                var webview = UIWebView();
                
                
                
                webview.frame = CGRect(x: 0,y: 0, width: (self.parent?.view.frame.size.width)!, height: (self.parent?.view.frame.size.height)!);
                
                var url = button?.webURL
                
                var request = NSURLRequest(url: url! )
                
                webview.scalesPageToFit=true
                
                webview.loadRequest(request as URLRequest)
                
                self.parent?.view.addSubview(webview)
                
                */
                
                
                
        
        
                
                
                
                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "webView") as! WebViewController
                
                
                vc.setTitle(title: (button?.title)!)
                
                vc.setPage(url: (button?.webURL)!)
              
           
                
                
                self.navigationController?.pushViewController(vc, animated:true)
                
            
                
            
                /*
                
                category = (button?.category)!
                
                previousCategory = category
                
                featured = false
                
                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "mainTable2") as! MainTableViewController
                
                
                self.navigationController?.pushViewController(vc, animated:true)
 
 
 */
                
            }
            
            
            
            
            
            
            
            
            
            if(button?.type == ButtonType.video) {
              
                
                var button =  category.sections[collectionView.tag].buttons[indexPath.row]
                
                var video  = search.searchForSingle((button?.videoID)!)
                
                
                
                
                
                let destination = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "detailView") as! VideoViewController
                
            
                
              
                
                
                
                suggestedSearch = category.sections[1]
                

          
                //let selectedVideo = videos[collectionView.tag][indexPath.row]
              
                destination.video = video.first
                
                
                
                destination.setDefaultSession(defaultSession: &defaultSession)
                
                destination.setDataTask(dataTask: &dataTask)
                
                
                destination.setDownloadsSession(downloadsSession: &downloadsSession)
                
                
                
                
                self.navigationController?.pushViewController(destination, animated:true)
                
                
              //  self.navigationController?.present(destination, animated:true)
                
                
                
            }
            
            
          
        
            
        }
 
/*
        
        if(collectionView.tag == 1 && indexPath.row == 0) {
            
            
            print("THSI IS WEHRE IT GETS WERIED")
            
            let viewController:CategoriesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Category") as! CategoriesViewController
            
            // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
            
            var parent = self.parent as! MainTableViewController
            
            
        //    viewController.category = parent.currentCategory
            
            previousCategory = category
            self.present(viewController, animated: true, completion: nil)
        }
        
*/
        
        
        
        
    }

}







extension HorizontalTableViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
}













