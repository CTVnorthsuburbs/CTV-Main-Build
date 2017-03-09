



//
//  HorizontalTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/21/16.
//
//

import UIKit


var selectedSection = 1


class HorizontalTableViewController: UITableViewController {
    
    var listOfVideos = [Int: [Video]]()
    
    var search = VideoSearch()
    
    var currentCategory: Category?
    
    var featuredVideos: [[Video?]]  = [[Video?]]()
    
    var videos : [[Video?]]  = [[Video?]]()
    
    var defaultDisplayCount = 15
    
    var sectionTitles = [String]()
    
    var upcomingEventsFeed = UpcomingEventsFeed()
    
    var defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
    
    var dataTask = URLSessionDataTask()
    
    lazy var downloadsSession: Foundation.URLSession = {
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
        
        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        return session
        
    }()
    
    
    @IBOutlet weak var tableCollection: UICollectionView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if(category.categoryTitle == featuredCategory.categoryTitle && currentCategory?.categoryTitle == featuredCategory.categoryTitle) {
            
            
            saveFeaturedVideos()
            
            
            
        }
        
        self.updateTable()
        
        
    }
    
    public func updateTable() {
        
        if(self.currentCategory?.categoryTitle != category.categoryTitle ) {
            
            
            if(category.categoryTitle == featuredCategory.categoryTitle && self.featuredVideos.count > 5 ) {
                
                
                self.currentCategory = category
                
                self.loadFeaturedVideos()
                
                self.tableView.reloadData()
                
                self.changeTableSize()
                
            } else  {
                
                self.currentCategory = category
                
                self.videos.removeAll()
                
                if(category.sections.count == 0) {
                    
                    category.createListing()
                    
                }
                self.currentCategory = category
                
                if(self.videos.count == 0) {
                    
                    DispatchQueue.main.async{
                        
                        LoadingOverlay.shared.showOverlay(view: self.parent?.view)
                        
                    }
                    DispatchQueue.global(qos: .background).async {
                        
                        var index = 0
                        
                        while (index < category.sections.count) {
                            
                            if(category.sections[index].searchID != nil) {
                                
                                if(category.sections[index].sectionType == SectionType.upcomingEventList) {
                                    
                                    upcomingEvents = self.upcomingEventsFeed.getUpcomingEventUpdate(category: category)!
                                    
                                    var videos = [Video]()
                                    
                                    videos =  self.upcomingEventsFeed.getUpcomingEventVideos(events: upcomingEvents)
                                    
                                    self.videos.append(videos)
                                    
                                } else {
                                    
                                    if(category.videoType == VideoType.cablecast) {
                                        
                                        let vids = self.search.search(category.sections[index].searchID!)
                                        
                                        //Was != nil which was always true
                                        
                                        if(  vids.count > 0) {
                                            
                                            if(self.listOfVideos.count >= category.sections[index].searchID! ) {
                                                
                                                self.listOfVideos[category.sections[index].searchID!] = vids
                                                
                                            }
                                            
                                            if(category.sections[index].getDisplayCount() != nil) {
                                                
                                                let trimmedVids = self.search.trimVideos(videoArray: vids, numberToReturn: category.sections[index].getDisplayCount()!)
                                                
                                                self.videos.append(trimmedVids)
                                                
                                            } else {
                                                
                                                let trimmedVids = self.search.trimVideos(videoArray: vids, numberToReturn: self.defaultDisplayCount)
                                                
                                                self.videos.append(trimmedVids)
                                                
                                            }
                                            
                                        }
                                        
                                    } else if(category.videoType == VideoType.youtube) {
                                        
                                        if(category.sections[index].getDisplayCount() == nil) {
                                            
                                            
                                            self.videos.append(self.search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)!)
                                            
                                            
                                        } else {
                                            
                                            
                                            let vids = self.search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)
                                            
                                            print("playlist \(category.sections[index].sectionPlaylist!) ")
                                            
                                            let trimmedVids = self.search.trimVideos(videoArray: vids!, numberToReturn: category.sections[index].getDisplayCount()!)
                                            
                                            self.videos.append(trimmedVids)
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            } else {
                                
                                self.videos.append([nil])
                                
                            }
                            
                            index = index + 1
                            
                        }
                        
                        DispatchQueue.main.async{
                            
                            self.tableView.reloadData()
                            
                            LoadingOverlay.shared.hideOverlayView()
                            
                        }
                        
                    }
                    
                    self.changeTableSize()
                    
                    if(category.categoryTitle == featuredCategory.categoryTitle && self.currentCategory?.categoryTitle == featuredCategory.categoryTitle) {
                        
                        self.saveFeaturedVideos()
                        
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
    
    public func refreshTable() {
        
        self.videos = [[Video?]]()
        
        DispatchQueue.main.async{
            
            LoadingOverlay.shared.showOverlay(view: self.parent?.view)
            
            var index = 0
            
            while (index < category.sections.count) {
                
                if(category.sections[index].searchID != nil) {
                    
                    if(category.videoType == VideoType.cablecast) {
                        
                        if(category.sections[index].sectionType == SectionType.upcomingEventList) {
                            
                            upcomingEvents = self.upcomingEventsFeed.getUpcomingEventUpdate(category: category)!
                            
                            var videos = [Video]()
                            
                            videos =  self.upcomingEventsFeed.getUpcomingEventVideos(events: upcomingEvents)
                            
                            self.videos.append(videos)
                            
                        } else {
                            
                            var vids = self.search.search(category.sections[index].searchID!)
                            
                            vids = self.search.trimVideos(videoArray: vids, numberToReturn: self.defaultDisplayCount)
                            
                            self.listOfVideos[category.sections[index].searchID!] = vids
                            
                            self.videos.append(vids)
                            
                        }
                        
                    } else if(category.videoType == VideoType.youtube) {
                        
                        if(category.sections[index].getDisplayCount() == nil) {
                            
                            self.videos.append(self.search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)!)
                            
                        } else {
                            
                            let vids = self.search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)
                            
                            let trimmedVids = self.search.trimVideos(videoArray: vids!, numberToReturn: category.sections[index].getDisplayCount()!)
                            
                            self.videos.append(trimmedVids)
                            
                        }
                        
                    }
                    
                    
                } else {
                    
                    self.videos.append([nil])
                    
                }
                
                index = index + 1
                
            }
            
            self.tableView.reloadData()
            
            LoadingOverlay.shared.hideOverlayView()
            
        }
        
        
        self.changeTableSize()
        
        if(category.categoryTitle == featuredCategory.categoryTitle && self.currentCategory?.categoryTitle == featuredCategory.categoryTitle) {
            
            self.saveFeaturedVideos()
            
        }
        
        
    }
    
    
    func saveFeaturedVideos() {
        
        featuredVideos = videos
        
    }
    
    func loadFeaturedVideos() {
        
        videos = featuredVideos
        
    }
    
    func changeTableSize() {
        
        var tableSize: CGFloat = 0
        
        for section in (currentCategory?.sections)! {
            
            switch section.sectionType {
                
            case .videoList:
                
                tableSize = tableSize + CGFloat(165)
                
            case .upcomingEventList:
                
                tableSize = tableSize + CGFloat(165)
                
            case .buttonNoTitle:
                
                tableSize = tableSize + CGFloat(100)
                
            case .buttonWithTitle:
                
                tableSize = tableSize + CGFloat(120)
                
            default:
                
                tableSize = tableSize + CGFloat(165)
                
            }
            
        }
        
        
        let parentVC = self.parent as! MainTableViewController
        
        parentVC.changeSize(height: Int(tableSize))
        
        self.tableView.frame.size.height = tableSize
        
        self.tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if(videos.count == 0) {
            
            return 0
            
        } else {
            
            return category.sections.count
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> HorizontalTableViewCell {
        
        let section = category.getSection(row: indexPath.section)
        
        if (section.sectionType == SectionType.slider) {
            
            self.tableView.rowHeight = 165.0
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? HorizontalTableViewCell
            
            cell!.sectionLabel.text = section.sectionTitle
            
            return cell!
            
        }
        
        if (section.sectionType == SectionType.upcomingEventList) {
            
            self.tableView.rowHeight = 165.0
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingCell", for: indexPath) as? HorizontalTableViewCell
            
            cell!.sectionLabel.text = section.sectionTitle
            
            if(section.displayCount == nil){
                
                section.displayCount = 15
                
            }
            
            return cell!
            
        }
        
        
        if (section.sectionType == SectionType.videoList) {
            
            
            self.tableView.rowHeight = 165.0
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? HorizontalTableViewCell
            
            cell!.sectionLabel.text = section.sectionTitle
            
            if(section.displayCount == nil){
                
                section.displayCount = 15
                
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
            
            return cell!
            
        }
        
        self.tableView.rowHeight = 165.0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? HorizontalTableViewCell
        
        cell!.sectionLabel.text = section.sectionTitle
        
        return cell!
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HorizontalTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, self, forRow: indexPath.section)
        
        tableViewCell.reloadCell()
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard cell is HorizontalTableViewCell else { return }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            
            if let collectionCell: HorizontalCollectionViewCell = sender as? HorizontalCollectionViewCell {
                
                if let collectionView: UICollectionView = collectionCell.superview as? UICollectionView {
                    
                    if let destination = segue.destination as? VideoViewController {
                        
                        DispatchQueue.main.async(){
                            
                            LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
                            
                        }
                        
                        let indexPath = collectionView.indexPath(for: collectionCell)!
                        
                        suggestedSearch = category.sections[collectionView.tag]
                        
                        let selectedVideo = self.videos[collectionView.tag][indexPath.row]
                        
                        destination.video = selectedVideo
                        
                        selectedSection = collectionView.tag
                        
                        destination.setDefaultSession(defaultSession: &self.defaultSession)
                        
                        destination.setDataTask(dataTask: &self.dataTask)
                        
                        destination.setDownloadsSession(downloadsSession: &self.downloadsSession)
                        
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
                    
                    selectedSection = indexPath.section
                    
                    destination.title = category.sections[indexPath.section].sectionTitle
                    
                    destination.categorySection = category.sections[indexPath.section]
                    
                }
                
            }
            
        }
        
    }
    
}


extension HorizontalTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(category.sections[collectionView.tag].sectionType == SectionType.videoList || category.sections[collectionView.tag].sectionType == SectionType.upcomingEventList) {
            
            let  count = videos[collectionView.tag].count
            
            return count
            
        } else if(category.sections[collectionView.tag].sectionType == SectionType.buttonWithTitle || category.sections[collectionView.tag].sectionType == SectionType.buttonNoTitle) {
            
            return category.sections[collectionView.tag].buttons.count
            
        }
        
        return videos[collectionView.tag].count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(category.sections[collectionView.tag].sectionType == SectionType.buttonWithTitle || category.sections[collectionView.tag].sectionType == SectionType.buttonNoTitle) {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCollectionCell", for: indexPath)
            
            var cells : ThumbnailButtonCell
            
            cells = cell as! ThumbnailButtonCell
            
            if (category.sections[collectionView.tag].buttons[indexPath.row]?.type == ButtonType.video) {
                
                if(category.sections[collectionView.tag].buttons[indexPath.row]?.imageOverlay != nil) {
                    
                    cells.textOverlay.text = category.sections[collectionView.tag].buttons[indexPath.row]?.imageOverlay
                    
                    
                } else {
                    
                    
                    cells.textOverlay.text = nil
                }
                
                
                var thumbnail: UIImage?
                
                if((category.sections[collectionView.tag].buttons[indexPath.row]?.videoID) == 1) {
                    
                    thumbnail = category.sections[collectionView.tag].buttons[indexPath.row]?.image
                    
                    cells.thumbnail.image = thumbnail
                    
                    
                } else {
                    
                    
                    let videoID = self.search.searchForSingle( (category.sections[collectionView.tag].buttons[indexPath.row]?.videoID)!)
                    
                    thumbnail =  self.search.getThumbnail(id: (videoID.first?.fileName)!)
                    
                    cells.thumbnail.image = thumbnail
                    
                    cells.thumbnail.alpha = 0.5
                    
                }
                
            } else {
                
                cells.thumbnail.image = category.sections[collectionView.tag].buttons[indexPath.row]?.image
                
                cells.textOverlay.text = nil
                
                cells.thumbnail.alpha = 1.0
                
            }
            
            cells.thumbnail.setRadius(radius: buttonRadius)
            
            return cells
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionCell", for: indexPath)
        
        var cells : HorizontalCollectionViewCell
        
        cells = cell as! HorizontalCollectionViewCell
        
        if(category.sections[collectionView.tag].sectionType == SectionType.upcomingEventList ) {
            
            var videos = [Video]()
            
            videos =  upcomingEventsFeed.getUpcomingEventVideos(events: upcomingEvents)
            
            self.videos[collectionView.tag] = videos
            
            if ( videos[indexPath.item].hasThumbnailUrl()) {
                
                cells.thumbnail.image = self.search.getThumbnail(url: (videos[indexPath.item].thumbnailUrl)!)
                
                cells.thumbnail.image = cells.thumbnail.image?.cropBottomImage(image: cells.thumbnail.image!)
                
            }
            
            cells.thumbnail.setRadius(radius: imageRadius)
            
            cells.titleLabel.text = videos[indexPath.item].title
            
            if (videos[indexPath.item].eventDate?.checkIfDateTimeIsToday())! {
                
                let time =  videos[indexPath.item].eventDate!.convertDateToTimeString()
                
                cells.dateLabel.text = "Today at \(time)"
                
            } else  if (videos[indexPath.item].eventDate?.checkIfDateTimeIsTomorrow())! {
                
                cells.dateLabel.text = "Tomorrow"
                
            } else {
                
                cells.dateLabel.text = videos[indexPath.item].eventDate?.convertEventDateToString()
                
            }
            
        }
        
        
        if(category.sections[collectionView.tag].sectionType == SectionType.videoList   ) {
            
            
            var videos = [Video]()
            
            if(category.videoType == VideoType.youtube) {
                
                videos =  search.getYouTubeVideos(playlist: category.sections[collectionView.tag].sectionPlaylist!)!
                
                
            } else if(category.videoType == VideoType.cablecast) {
                
                
                if (listOfVideos.keys.contains(category.sections[collectionView.tag].searchID!)) {
                    
                    
                    videos = listOfVideos[category.sections[collectionView.tag].searchID!]!
                    
                    
                } else {
                    
                    listOfVideos[category.sections[collectionView.tag].searchID!] = search.search(category.sections[collectionView.tag].searchID!)
                    
                    videos = listOfVideos[category.sections[collectionView.tag].searchID!]!
                    
                }
                
            }
            
            
            if (videos[indexPath.item].fileName != nil) {
                
                
                if( videos[indexPath.item].hasThumbnailUrl()) {
                    
                    cells.thumbnail.image = self.search.getThumbnail(url: (videos[indexPath.item].thumbnailUrl)!)
                    
                    
                } else {
                    
                    videos[indexPath.item].generateThumbnailUrl()
                    
                    cells.thumbnail.image = self.search.getThumbnail(url: (videos[indexPath.item].thumbnailUrl)!)
                    
                }
                
                cells.thumbnail.setRadius(radius: imageRadius)
                
                cells.titleLabel.text = videos[indexPath.item].title
                
                cells.dateLabel.text =  videos[indexPath.item].eventDate!.convertDateToString()
                
            } else {
                
                cells.thumbnail.image = #imageLiteral(resourceName: "placeholder-header")
                
                cells.thumbnail.setRadius(radius: imageRadius)
                
                
                cells.titleLabel.text = videos[indexPath.item].title
                
                cells.dateLabel.text =  videos[indexPath.item].eventDate!.convertDateToString()
                
            }
        }
        
        return cell
        
    }
    
    func setCategory(newCategory: Category) {
        
        self.currentCategory = newCategory
        
        category = newCategory
        
        category.createListing()
        
        currentCategory = category
        
        videos.removeAll()
        
        var index = 0
        
        while (index < category.sections.count) {
            
            if(category.sections[index].searchID != nil) {
                
                if(category.sections[index].getDisplayCount() == nil) {
                    
                    videos.append(search.search(category.sections[index].searchID!))
                    
                } else {
                    
                    let vids = search.search(category.sections[index].searchID!)
                    
                    let trimmedVids = search.trimVideos(videoArray: vids, numberToReturn: category.sections[index].getDisplayCount()!)
                    
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
            
            let button = buttons[indexPath.row]
            
            if(button?.type == ButtonType.category) {
                
                LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "mainTable2") as! MainTableViewController
                    
                    vc.setCategory(newCategory: (button?.category)!)
                    
                    self.currentCategory = button?.category!
                    
                    self.navigationController?.show(vc, sender: self)
                    
                    DispatchQueue.main.async( execute: {
                        
                        LoadingOverlay.shared.hideOverlayView()
                    })
                    
                    
                }
                
            }
            
            if(button?.type == ButtonType.page) {
                
                let page = button?.page
                
                let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: page!)
                
                vc.title = button?.title
                
                self.navigationController?.pushViewController(vc, animated:true)
                
            }
            
            if(button?.type == ButtonType.webPage) {
                
                /*
                 
                 //This code is used to open a external webpage inside a webview within the app  it was disabled because jwplayer 6 videos will not play in webview
                 
                 let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "webView") as! WebViewController
                 
                 vc.setTitle(title: (button?.title)!)
                 
                 vc.setPage(url: (button?.webURL)!)
                 
                 self.navigationController?.pushViewController(vc, animated:true)
                 
                 */
                
                //This code opens an external web view in safari
                
                if let url =  button?.webURL {
                    
                    UIApplication.shared.openURL(url)
                    
                }
                
            }
            
            if(button?.type == ButtonType.video) {
                
                if( category.sections[collectionView.tag].buttons[indexPath.row]?.videoID == 1 &&  category.videoType != VideoType.youtube) {
                    
                    LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        let button =  category.sections[collectionView.tag].buttons[indexPath.row]
                        
                        let destination = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "detailView") as! VideoViewController
                        
                        let video  = Video(title: button!.title!, thumbnail: button?.image, fileName: 1, sourceUrl:  button?.webURL?.absoluteString, comments: "", eventDate: Date(), thumbnailUrl: nil, id: button?.videoID, isEvent: false, endDate: nil)
                        
                        suggestedSearch = category.sections[0]
                        
                        destination.video = video
                        
                        destination.setDefaultSession(defaultSession: &self.defaultSession)
                        
                        destination.setDataTask(dataTask: &self.dataTask)
                        
                        destination.setDownloadsSession(downloadsSession: &self.downloadsSession)
                        
                        self.navigationController?.pushViewController(destination, animated:true)
                        
                        DispatchQueue.main.async( execute: {
                            
                            LoadingOverlay.shared.hideOverlayView()
                            
                        })
                        
                    }
                    
                } else {
                    
                    LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        let button =  category.sections[collectionView.tag].buttons[indexPath.row]
                        
                        let video  = self.search.searchForSingle((button?.videoID)!)
                        
                        let destination = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "detailView") as! VideoViewController
                        
                        destination.video = video.first
                        
                        suggestedSearch = category.sections[0]
                        
                        destination.setDefaultSession(defaultSession: &self.defaultSession)
                        
                        destination.setDataTask(dataTask: &self.dataTask)
                        
                        destination.setDownloadsSession(downloadsSession: &self.downloadsSession)
                        
                        self.navigationController?.pushViewController(destination, animated:true)
                        
                        DispatchQueue.main.async( execute: {
                            
                            LoadingOverlay.shared.hideOverlayView()
                            
                        })
                        
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
}


extension HorizontalTableViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
}













