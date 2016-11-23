//
//  Category.swift
//  HalfTunes
//
//  Created by William Ogura on 11/17/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit




enum CategorySearches: Int {
    
    case recent = 52966
    
    case baseball = 67200
    // case baseball = 65794
    case hockey = 65794
    
    case basketball = 67204
    
    case nsb = 66603
    
    case concerts = 67318
    
    
    
}





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


class CategoryFactorySettings {
    
    var categoryTitle: String?
    
    var popularSectionTitle: String?
    
    var popularSectionSearchID: Int?
    
    var popularSectionDisplayCount: Int?
    
    var recentGirlsSectionTitle: String?
    
    var recentGirlsSectionSearchID: Int?
    
    var recentGirlsSectionDisplayCount: Int?
    
    var recentBoysSectionTitle: String?
    
    var recentBoysSectionSearchID: Int?
    
    var recentBoysSectionDisplayCount: Int?
    
    var featuredSectionTitle: String?
    
    var featuredSectionSearchID: Int?
    
    var featuredSectionDisplayCount: Int?
    
    var recentSectionTitle: String?
    
    var recentSectionSearchID: Int?
    
    var recentSectionDisplayCount: Int?
    
    var categoryOrder: [CategoryOrder]?
    
    var sliderImages: [UIImage]?
    
    
    
}

enum CategoryOrder {
    
    case recent
    
    case featured
    
    case popular
    
    case girls
    
    case boys
    
    case button
    
}


class hockeyFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Hockey"
        
        self.popularSectionTitle = "Popular Hockey Videos"
        
        self.popularSectionSearchID = 68483
        
        self.recentGirlsSectionTitle = "Girls Recent Hockey Games"
        
        self.recentGirlsSectionSearchID = 68489
        
        self.recentBoysSectionTitle = "Boys Hockey Games"
        
        self.recentBoysSectionSearchID = 68492
        
        self.featuredSectionTitle = "Featured Hockey Games"
        
        self.featuredSectionSearchID = 65794
        
        self.recentSectionTitle = "Recent Hockey Games"
        
        self.recentSectionSearchID = 65794
        
        self.sliderImages = nil
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular, CategoryOrder.boys, CategoryOrder.girls]
        
    }
    
}


class featuredFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Featured Videos"
        
        self.popularSectionTitle = "New & Noteworthy"
        
        self.popularSectionSearchID = 52966
        
        self.popularSectionDisplayCount = 15
        
        self.recentGirlsSectionTitle = "Concerts"
        
        self.recentGirlsSectionSearchID = 67318
        
        self.recentGirlsSectionDisplayCount = 10
        
        self.recentBoysSectionTitle = "Local News"
        
        self.recentBoysSectionSearchID = 66603
        
        self.recentBoysSectionDisplayCount = 5
        
        self.featuredSectionTitle = "Baseball Season"
        
        self.featuredSectionSearchID = 67200
        
        self.featuredSectionDisplayCount = 20
        
        self.recentSectionTitle = "Recent Hockey Games"
        
        self.recentSectionSearchID = 65794
        
        self.categoryOrder = [CategoryOrder.popular, CategoryOrder.recent, CategoryOrder.button,  CategoryOrder.boys, CategoryOrder.girls,  CategoryOrder.featured]
        
    }
    
}

class baseballFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Baseball"
        
        self.popularSectionTitle = "Popular Baseball Videos"
        
        self.popularSectionSearchID = 68755
        
        self.recentGirlsSectionTitle = "Softball Games"
        
        self.recentGirlsSectionSearchID = 68774
        
        self.recentBoysSectionTitle = "Boys Baseball Games"
        
        self.recentBoysSectionSearchID = 68492
        
        self.featuredSectionTitle = "Featured Baseball Games"
        
        self.featuredSectionSearchID = 65797
        
        self.recentSectionTitle = "Recent Baseball Games"
        
        self.recentSectionSearchID = 65797
        
        self.sliderImages = [#imageLiteral(resourceName: "softball_slider")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular,  CategoryOrder.girls]
        
    }
    
}


class volleyballFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Volleyball"
        
        self.popularSectionTitle = "Popular Volleyball Videos"
        
        self.popularSectionSearchID = 68755
        
        self.recentGirlsSectionTitle = "Softball Games"
        
        self.recentGirlsSectionSearchID = 68774
        
        self.recentBoysSectionTitle = "Boys Baseball Games"
        
        self.recentBoysSectionSearchID = 68492
        
        self.featuredSectionTitle = "Featured Baseball Games"
        
        self.featuredSectionSearchID = 65797
        
        self.recentSectionTitle = "Recent Volleyball Games"
        
        self.recentSectionSearchID = 65797
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular,   CategoryOrder.girls, ]
        
    }
    
}

class basketballFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Basketball"
        
        self.popularSectionTitle = "Popular Basketball Videos"
        
        self.popularSectionSearchID = 68755
        
        self.recentGirlsSectionTitle = "Softball Games"
        
        self.recentGirlsSectionSearchID = 68774
        
        self.recentBoysSectionTitle = "Boys Basketball Games"
        
        self.recentBoysSectionSearchID = 68492
        
        self.featuredSectionTitle = "Featured Basketball Games"
        
        self.featuredSectionSearchID = 65797
        
        self.recentSectionTitle = "Recent Basketball Games"
        
        self.recentSectionSearchID = 65797
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular,  CategoryOrder.girls]
        
    }
    
}


class baseballButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "softball_slider")
        
        self.title = "Baseball"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: baseballFactorySettings()))
        
    }
    
}

class hockeyButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "hockey")
        
        self.title = "Hockey"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: hockeyFactorySettings()))
        
    }
    
}

class volleyballButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "volleyball")
        
        self.title = "Volleyball"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: volleyballFactorySettings()))
        
    }
    
}

class basketballButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "basketball")
        
        self.title = "Basketball"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: basketballFactorySettings()))
        
    }
    
}






class CategoryFactory {
    
    
    var settings: CategoryFactorySettings
    
    
    
    init(factorySettings: CategoryFactorySettings) {
        
        self.settings = factorySettings
        
    }
    
    internal func addPopularSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.popularSectionTitle
        
        let searchID = settings.popularSectionSearchID
        
        var displayCount = settings.popularSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images)
        
        return section
    }
    
    internal func addRecentGirlsSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recentGirlsSectionTitle
        
        let searchID = settings.recentGirlsSectionSearchID
        
        var displayCount = settings.recentGirlsSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images)
        
        return section
        
        
    }
    
    internal func addRecentBoysSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recentBoysSectionTitle
        
        let searchID = settings.recentBoysSectionSearchID
        
        var displayCount = settings.recentBoysSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images)
        
        return section
        
    }
    
    internal func addFeaturedSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.featuredSectionTitle
        
        let searchID = settings.featuredSectionSearchID
        
        var displayCount = settings.featuredSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images)
        
        return section
        
    }
    
    internal func addRecentSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recentSectionTitle
        
        let searchID = settings.recentSectionSearchID
        
        var displayCount = settings.recentSectionDisplayCount
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: displayCount, images: images)
        
        return section
        
    }
    
    internal func addButtons() -> Section {
        
        let sectionType = SectionType.buttonWithTitle
        
        let sectionTitle: String? = "Browse By Sport"
        
        let searchID: Int?  = nil
        
        let videoList: [Int]? = nil
        
        var buttons = [Button]()
        
        
        
        buttons.append(Button(factory:hockeyButtonFactory()))
        
        buttons.append(Button(factory:baseballButtonFactory()))
        
        buttons.append(Button(factory:volleyballButtonFactory()))
        
        buttons.append(Button(factory:basketballButtonFactory()))
        
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: nil, images: images)
        
        return section
        
    }
    
    
    
    internal func addSlide() -> Section {
        
        let sectionType = SectionType.slider
        
        let sectionTitle = "Slider listing"
        
        let searchID = 68489
        
        let videoList: [Int]? = nil
        
        let buttons: [Button]? = nil
        
        let images: [UIImage]? = settings.sliderImages
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: nil, images: images)
        
        return section
        
    }
    
    internal func getOrder() -> [CategoryOrder] {
        
        return settings.categoryOrder!
        
        
    }
}





class Category {
    
    
    var categoryFactory: CategoryFactory
    
    var categoryTitle: String
    
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
        
        
    }
    
    
    func createListing() {
        
        createSlider()
        
        var order = categoryFactory.getOrder()
        
        
        
        for section in order {
            
            switch section {
                
            case CategoryOrder.recent:
                
                createRecentSection()
                
            case CategoryOrder.popular:
                
                createPopularSection()
                
            case CategoryOrder.featured:
                
                createFeaturedSection()
                
            case CategoryOrder.button:
                
                createButtonSection()
                
            case CategoryOrder.boys:
                
                createRecentBoysSection()
                
            case CategoryOrder.girls:
                
                createRecentGirlsSection()
                
            default: break
                
                
            }
            
            
            
        }
        
        
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
    
    
    func getSection(row: Int) -> Section {
        
        return sections[row]
        
    }
    
}

class Section {
    
    var sectionType: SectionType
    
    var listing = CategorySearches.hockey
    
    var displayCount:  Int?
    
    var sectionTitle: String?
    
    var searchID: Int?
    
    var videoList: [Int]?
    
    var buttons = [Button?]()
    
    var images = [UIImage?]()
    
    init(sectionType: SectionType, sectionTitle: String?, searchID: Int?, videoList: [Int]?, buttons: [Button]?, displayCount: Int?, images: [UIImage]?) {
        
        self.sectionType = sectionType
        
        self.sectionTitle = sectionTitle
        
        self.searchID = searchID
        
        self.videoList = videoList
        
        if(buttons != nil) {
            
          self.buttons = buttons!
            
        }
        
        if(images != nil) {
            
              self.images = images!
        
        }
        
      
        
        
        
        self.displayCount = displayCount
        
        
        
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
    
}



class ButtonFactory {
    
    var type: ButtonType? = nil
    
    var image: UIImage? = nil
    
    var title: String? = nil
    
    var imageOverlay: String? = nil
    
    var page: String? = nil
    
    var category: Category? = nil
    
    
    func getType() -> ButtonType? {
        
        return type
        
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
    
}



enum ButtonType {
    
    case video
    
    case category
    
    case page
    
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
    
    
    init(factory: ButtonFactory) {
        
        self.factory = factory
        
        self.type = factory.getType()
        
        self.image = factory.getImage()
        
        self.title = factory.getTitle()
        
        self.imageOverlay = factory.getImageOverlay()
        
        self.page = factory.getPage()
        
        self.category = factory.getCategory()
    }
    
}



