//
//  Category.swift
//  HalfTunes
//
//  Created by William Ogura on 11/17/16.
//  
//

import Foundation

import UIKit



var categories: [Category] = [Category(categoryFactory: CategoryFactory(factorySettings: home())), Category(categoryFactory: CategoryFactory(factorySettings: baseball())), Category(categoryFactory: CategoryFactory(factorySettings: basketball())),Category(categoryFactory: CategoryFactory(factorySettings: community())),  Category(categoryFactory: CategoryFactory(factorySettings: football())),Category(categoryFactory: CategoryFactory(factorySettings: gymnastics())), Category(categoryFactory: CategoryFactory(factorySettings: hockey())), Category(categoryFactory: CategoryFactory(factorySettings: lacrosse())), Category(categoryFactory: CategoryFactory(factorySettings: parades())), Category(categoryFactory: CategoryFactory(factorySettings: programs())),Category(categoryFactory: CategoryFactory(factorySettings: soccer())),Category(categoryFactory: CategoryFactory(factorySettings: softball())), Category(categoryFactory: CategoryFactory(factorySettings: swimming())), Category(categoryFactory: CategoryFactory(factorySettings: teens())), Category(categoryFactory: CategoryFactory(factorySettings: volleyball())), Category(categoryFactory: CategoryFactory(factorySettings: ctvyoutube())) ]







enum Listing {
    
    case category
    
    case show
    
    case event
    
    case about
    
    case schedule
    
    case hockey
    
    case baseball
    
    case basketball
    
    case gymnastics
    
    case swimming
    
    case soccer
    
    case lacrosse
    
    case volleyball
    
    case football
    
}

enum VideoType {
    
    case cablecast
    
    case youtube
    
  
    
  
}


class CategoryFactorySettings: NSObject {
    
    required override init() {
        
    }
    
    var categoryTitle: String?
    
    var videoType = VideoType.cablecast
    
    
    
    var upcomingSectionTitle: String?
    
    var upcomingSectionSearchID: Int?
    
    var upcomingSectionDisplayCount: Int?
    
    var upcomingSectionPlaylist: String?
    
    
    var popularSectionTitle: String?
    
    var popularSectionSearchID: Int?
    
    var popularSectionDisplayCount: Int?
    
    var popularSectionPlaylist: String?
    
    
    var recentGirlsSectionTitle: String?
    
    var recentGirlsSectionSearchID: Int?
    
    var recentGirlsSectionDisplayCount: Int?
    
     var recentGirlsSectionPlaylist: String?
    
    
    var recentBoysSectionTitle: String?
    
    var recentBoysSectionSearchID: Int?
    
    var recentBoysSectionDisplayCount: Int?
    
    var recentBoysSectionPlaylist: String?
    
    
    
    var featuredSectionTitle: String?
    
    var featuredSectionSearchID: Int?
    
    var featuredSectionDisplayCount: Int?
    
    var featuredSectionPlaylist: String?
    
    
    
    var recentSectionTitle: String?
    
    var recentSectionSearchID: Int?
    
    var recentSectionDisplayCount: Int?
    
    var recentSectionPlaylist: String?
    
    
    var categoryOrder: [CategoryOrder]?
    
    
    var sliderImages: [UIImage]?
    
    var slides = [Slide]()
    

    
    var buttonsSectionTitle: String?
    
    var buttonsSectionType: SectionType?
    
    
    var buttonsSecondTitle: String?
    
    var buttonsSecondSectionType: SectionType?
    
    
    var buttonsThirdTitle: String?
    
    var buttonsThirdSectionType: SectionType?
    
    
    var buttons = [Button]()
    
    var buttonsSecond = [Button]()
    
    var buttonsThird = [Button]()
    
    
    
}

enum CategoryOrder {
    
    case upcoming
    
    case recent
    
    case featured
    
    case popular
    
    case girls
    
    case boys
    
    case button
    
    case buttonSecond
    
    case buttonThird
    
}









class CategoryFactory {
    
    
    var settings: CategoryFactorySettings
    
    
    
    init(factorySettings: CategoryFactorySettings) {
        
        self.settings = factorySettings
        
    }
    
    
    internal func addUpcomingSection() -> Section {
        
        let sectionType = SectionType.upcomingEventList
        
        let sectionTitle = settings.upcomingSectionTitle
        
        let searchID = settings.upcomingSectionSearchID
        
        let displayCount = settings.upcomingSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
        let sectionPlaylist = settings.upcomingSectionPlaylist
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images, sectionPlaylist: sectionPlaylist)
        
        return section
    }
    
    internal func addPopularSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.popularSectionTitle
        
        let searchID = settings.popularSectionSearchID
        
        let displayCount = settings.popularSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
        let sectionPlaylist = settings.popularSectionPlaylist
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images, sectionPlaylist: sectionPlaylist)
        
        return section
    }
    
    internal func addRecentGirlsSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recentGirlsSectionTitle
        
        let searchID = settings.recentGirlsSectionSearchID
        
        let displayCount = settings.recentGirlsSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
       let sectionPlaylist = settings.recentGirlsSectionPlaylist
        
        let images: [UIImage]? = nil
        
         let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images, sectionPlaylist: sectionPlaylist)
        
        return section
        
        
    }
    
    internal func addRecentBoysSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recentBoysSectionTitle
        
        let searchID = settings.recentBoysSectionSearchID
        
        let displayCount = settings.recentBoysSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
       let sectionPlaylist = settings.recentBoysSectionPlaylist
        
        let images: [UIImage]? = nil
        
           let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images, sectionPlaylist: sectionPlaylist)
        
        return section
        
    }
    
    internal func addFeaturedSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.featuredSectionTitle
        
        let searchID = settings.featuredSectionSearchID
        
        let displayCount = settings.featuredSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
         let sectionPlaylist = settings.featuredSectionPlaylist
        
        let images: [UIImage]? = nil
        
           let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images, sectionPlaylist: sectionPlaylist)
        
        return section
        
    }
    
    internal func addRecentSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recentSectionTitle
        
        let searchID = settings.recentSectionSearchID
        
        let displayCount = settings.recentSectionDisplayCount
        
         let sectionPlaylist = settings.recentSectionPlaylist
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
        
        
        let images: [UIImage]? = nil
        
         let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images, sectionPlaylist: sectionPlaylist)
        
        return section
        
    }
    
    internal func addButtons() -> Section {
        
        let sectionType = settings.buttonsSectionType
        
        let sectionTitle = settings.buttonsSectionTitle
        
        
        
        let searchID: Int?  = nil
        
        let videoList: [Int]? = nil
        
        let buttons = settings.buttons
        
      
     
        
   
        
        
        let images: [UIImage]? = nil
        
          let section = Section(sectionType: sectionType!, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: nil, images: images, sectionPlaylist: nil)
        
        return section
        
    }
    
    
    internal func addButtonsSecond() -> Section {
        
        let sectionType = settings.buttonsSecondSectionType
        let sectionTitle = settings.buttonsSecondTitle
        
        let searchID: Int?  = nil
        
        let videoList: [Int]? = nil
        
        let buttons = settings.buttonsSecond
        

        
     
        
        
        let images: [UIImage]? = nil
        
           let section = Section(sectionType: sectionType!, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: nil, images: images, sectionPlaylist: nil)
        
        return section
        
    }
    
    
    internal func addButtonsThird() -> Section {
        
        let sectionType = settings.buttonsThirdSectionType
        let sectionTitle = settings.buttonsThirdTitle
        
        let searchID: Int?  = nil
        
        let videoList: [Int]? = nil
        
        let buttons = settings.buttonsThird
        
        
        
        
        
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType!, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: nil, images: images, sectionPlaylist: nil)
        
        return section
        
    }
    
    
    
    
    internal func addSlide() -> Section {
        
        /*
        var sliderImages: [UIImage]?
        
        var sliderType: Category.Type?
        
        var sliderURL: URL?
        
        var sliderPage: String?
        
        var sliderSearchID: Int?
        
        var sliderCategory: Category?
        */
        
        
        let slides = settings.slides
        
        
        
        let sectionType = SectionType.slider
        
        let sectionTitle = "Slider listing"
        
        let searchID = 000
        
    

        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
      
        
        let images: [UIImage]? = settings.sliderImages
        
          let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: nil, images: images, sectionPlaylist: nil)
        
        
        for slide in slides {
            
            
            
            section.addSlide(slide: slide)
            
            
        }
        
        return section
        
    }
    
    internal func getOrder() -> [CategoryOrder] {
        
        return settings.categoryOrder!
        
        
    }
}





class Category {
    
    
    var categoryFactory: CategoryFactory
    
    var categoryTitle: String
    
    var videoType: VideoType
    
    var sections = [Section]()
    
    var slider: Section?
    
    func getSlider() -> Section? {
        
        
        if(slider != nil) {
           
          return slider!
        }
      
      return nil
        
    }
    
    
    required init(categoryFactory: CategoryFactory) {
        
        self.categoryFactory = categoryFactory
        
        self.categoryTitle = categoryFactory.settings.categoryTitle!
        
        self.videoType = categoryFactory.settings.videoType
        
        
    }
    
    
    func createListing() {
        
        createSlider()
        
        let order = categoryFactory.getOrder()
        
        
        
        for section in order {
            
            switch section {
                
            case CategoryOrder.upcoming:
                
                createUpcomingSection()
                
            case CategoryOrder.recent:
                
                createRecentSection()
                
            case CategoryOrder.popular:
                
                createPopularSection()
                
            case CategoryOrder.featured:
                
                createFeaturedSection()
                
            case CategoryOrder.button:
                
                createButtonSection()
                
            case CategoryOrder.buttonSecond:
                
                createButtonSectionSecond()
                
            case CategoryOrder.buttonThird:
                
                createButtonSectionThird()
                
            case CategoryOrder.boys:
                
                createRecentBoysSection()
                
            case CategoryOrder.girls:
                
                createRecentGirlsSection()
                
            
                
                
            }
            
            
            
        }
        
        
    }
    
    func createUpcomingSection() {
        
        sections.append(categoryFactory.addUpcomingSection())
        
        
        
    }
    
    func createFeaturedSection() {
        
        sections.append(categoryFactory.addFeaturedSection())
        
        
        
    }
    
    func createSlider() {
        
        slider = (categoryFactory.addSlide())
        
    }
    
    func createRecentSection() {
        
        sections.append(categoryFactory.addRecentSection())
        
    }
    
    func createRecentBoysSection() {
        
        sections.append(categoryFactory.addRecentBoysSection())
        
    }
    
    func createRecentGirlsSection() {
        
        sections.append(categoryFactory.addRecentGirlsSection())
        
    }
    
    func createPopularSection() {
        
        sections.append(categoryFactory.addPopularSection())
        
    }
    
    func createSpecificSection() {
        
        
    }
    
    func createSpecificSearchSection() {
        
        
    }
    
    func createButtonSection() {
        
        
        sections.append(categoryFactory.addButtons())
        
    }
    
    func createButtonSectionSecond() {
        
        sections.append(categoryFactory.addButtonsSecond())
    }
    
    func createButtonSectionThird() {
        
        sections.append(categoryFactory.addButtonsThird())
    }
    
    func getSection(row: Int) -> Section {
        
        return sections[row]
        
    }
    
}


class Slide {
    
    var slideType: ButtonType?
    
    var searchID: Int?
    
    var videoList: Int?
    
    var page: String?
    
    var category: CategoryFactorySettings?
    
    var image: UIImage?
    
    var title: String?
    
    var webURL: URL?
    
    init(slideType: ButtonType?, searchID: Int?, videoList: Int?, page: String?, category: CategoryFactorySettings?, image: UIImage?, title: String?, webURL: URL?) {
        
        self.slideType = slideType
        
        self.searchID = searchID
        
        self.videoList = videoList
        
        self.page = page
        
        self.category = category
        
        self.image = image
        
        self.title = title
        
        self.webURL = webURL
        
        
        
        
    }
    
    
    
}

class Section {
    
    var sectionType: SectionType
    
   // var listing = CategorySearches.hockey
    
    var displayCount:  Int?
    
    var sectionTitle: String?
    
    var sectionPlaylist: String?
    
    var searchID: Int?
    
    var videoList: [Int]?
    
    var buttons = [Button?]()
    
    var images = [UIImage?]()
    
    var slides = [Slide]()
    
    init(sectionType: SectionType, sectionTitle: String?, searchID: Int?, videoList: [Int]?, buttons: [Button]?, displayCount: Int?, images: [UIImage]?, sectionPlaylist: String?) {
        
        self.sectionType = sectionType
        
        self.sectionTitle = sectionTitle
        
        self.searchID = searchID
        
        self.videoList = videoList
        
        self.sectionPlaylist = sectionPlaylist
        
        if(buttons != nil) {
            
          self.buttons = buttons!
            
        }
        
        if(images != nil) {
            
              self.images = images!
        
        }
        
        self.displayCount = displayCount
        
    }
    
    func addSlide(slide: Slide) {
        
        slides.append(slide)
        
        
    }
    
    func getSlide(position: Int) -> Slide? {
        
        
        if(slides.count >= position - 1) {
            
            
            
            return slides[position - 1]
        }
        
        return nil
        
    }
    
    func getCategoryImage() -> UIImage {
        
        return images.first!!
        
    }
    
    func getDisplayCount() -> Int? {
        
        return displayCount
        
    }
    
    
}

enum SectionType {
    
    case buttonNoTitle
    
    case videoList
    
    case buttonWithTitle
    
    case slider
    
    case specificVideoList
    
    case upcomingEventList
  
}



class ButtonFactory {
    
    var type: ButtonType? = nil
    
    var image: UIImage? = nil
    
    var title: String? = nil
    
    var imageOverlay: String? = nil
    
    var page: String? = nil
    
    var category: Category? = nil
    
    var videoID: Int? = nil
    
    var webURL: URL? = nil
    
    
    func getType() -> ButtonType? {
        
        return type
        
    }
    
    func getVideoID() -> Int? {
        
        return videoID
    }
    
    
    func getImage() -> UIImage? {
        
        return image
        
    }
    
    func setImage(url: String) {
        
        let escapedString = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let url = NSURL(string: escapedString! )
        
        if(url != nil) {
            let data = NSData(contentsOf: url! as URL)
            
            self.image = UIImage(data: data! as Data)!
            
        }
        
    }
    
    func getTitle() -> String? {
        
        
        
        return title
        
    }
    
    func getImageOverlay() -> String? {
        
        
        
        
        return imageOverlay
        
    }
    
    func getPage() -> String? {
        
        
        
        return page
    }
    
    func getCategory() -> Category? {
        
        
        
        
        return category
        
    }
    
    func getWebURL() -> URL? {
        
        return webURL
        
    }
    
    
}



enum ButtonType {
    
    case video
    
    case category
    
    case page
    
    case webPage
    
    case liveEvent
    
}


class Button {
    
    var factory: ButtonFactory
    
    var type: ButtonType?
    
    var image: UIImage?
    
    var imageURL: String?
    
    var title: String?
    
    var imageOverlay: String?
    
    var page: String?
    
    var category: Category?
    
    var videoID: Int?
    
    var webURL: URL?
    
    
    init(factory: ButtonFactory) {
        
        self.factory = factory
        
        self.type = factory.getType()
        
        self.image = factory.getImage()
        
        self.title = factory.getTitle()
        
        self.imageOverlay = factory.getImageOverlay()
        
        self.page = factory.getPage()
        
        self.category = factory.getCategory()
        
        self.videoID = factory.getVideoID()
        
        self.webURL = factory.getWebURL()
        
        
    }
    
}



