//
//  Category.swift
//  HalfTunes
//
//  Created by William Ogura on 11/17/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit



var categories: [Category] = [Category(categoryFactory: CategoryFactory(factorySettings: featuredFactorySettings())), Category(categoryFactory: CategoryFactory(factorySettings: baseballFactorySettings())), Category(categoryFactory: CategoryFactory(factorySettings: basketballFactorySettings())),Category(categoryFactory: CategoryFactory(factorySettings: communityFactorySettings())), Category(categoryFactory: CategoryFactory(factorySettings: footballFactorySettings())),Category(categoryFactory: CategoryFactory(factorySettings: gymnasticsFactorySettings())), Category(categoryFactory: CategoryFactory(factorySettings: hockeyFactorySettings())), Category(categoryFactory: CategoryFactory(factorySettings: lacrosseFactorySettings())),Category(categoryFactory: CategoryFactory(factorySettings: programsFactorySettings())),Category(categoryFactory: CategoryFactory(factorySettings: soccerFactorySettings())),Category(categoryFactory: CategoryFactory(factorySettings: softballFactorySettings())), Category(categoryFactory: CategoryFactory(factorySettings: swimmingFactorySettings())), Category(categoryFactory: CategoryFactory(factorySettings: volleyballFactorySettings())) ]

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
    
    case recent
    
    case featured
    
    case popular
    
    case girls
    
    case boys
    
    case button
    
    case buttonSecond
    
    case buttonThird
    
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



class communityFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Community"
        
        self.popularSectionTitle = "Popular Community Videos"
        
        self.popularSectionSearchID = 71301
        
 
        
        self.recentSectionTitle = "Recent Community Videos"
        
        self.recentSectionSearchID = 71296
        
        self.sliderImages = [#imageLiteral(resourceName: "community-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}



class programsFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Programs"
        
        self.popularSectionTitle = "Parades"
        
        self.popularSectionSearchID = 71341
        
        self.recentGirlsSectionTitle = "What's Brewin'"
        
        self.recentGirlsSectionSearchID = 71346
        
        self.recentBoysSectionTitle = "Disability Viewpoints"
        
        self.recentBoysSectionSearchID = 71349
        
        self.featuredSectionTitle = "Tales of Our Cities"
        
        self.featuredSectionSearchID = 71328
        
        self.recentSectionTitle = "North Suburban Beat"
        
        self.recentSectionSearchID = 66603
        
        self.sliderImages = [#imageLiteral(resourceName: "programs-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.featured,   CategoryOrder.girls,  CategoryOrder.popular, CategoryOrder.boys]
        
    }
    
}





class footballFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Football"
        
        self.popularSectionTitle = "Most Viewed Football Videos"
        
        self.popularSectionSearchID = 69223
        
        
        
        self.recentSectionTitle = "Recent Games"
        
        
        
        
        self.recentSectionSearchID = 69238
        
        self.sliderImages = [#imageLiteral(resourceName: "football-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular ]
        
    }
    
}


class volleyballFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Volleyball"
        
        self.popularSectionTitle = "Most Viewed Volleyball Videos"
        
        self.popularSectionSearchID = 69299
        

        
        self.recentSectionTitle = "Recent Volleyball Games"
        
        
        
        
        self.recentSectionSearchID = 69308
        
        self.sliderImages = [#imageLiteral(resourceName: "volleyball-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular ]
        
    }
    
}

class basketballFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Basketball"
        
        self.popularSectionTitle = "Popular Basketball Videos"
        
        self.popularSectionSearchID = 69103
        
       
        
        self.recentGirlsSectionTitle = "Girls Games"
        
        self.recentGirlsSectionSearchID = 69126
        
        self.recentBoysSectionTitle = "Boys Basketball Games"
        
        self.recentBoysSectionSearchID = 69146
        
        
        self.recentSectionTitle = "Recent Basketball Games"
        
        self.recentSectionSearchID = 69113
        
        
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular,  CategoryOrder.boys, CategoryOrder.girls]
        
        
        
    }
    
}

class soccerFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Soccer"
        
        self.popularSectionTitle = "Popular Soccer Videos"
        
        self.popularSectionSearchID = 69278
        
   
        
        
        self.recentSectionTitle = "Recent Games"
        
        self.recentSectionSearchID = 69275
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "soccer-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}


class hockeyFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Hockey"
        
        self.popularSectionTitle = "Popular Games"
        
        self.popularSectionSearchID = 68483
        
        self.recentGirlsSectionTitle = "Girls Games"
        
        self.recentGirlsSectionSearchID = 68489
        
        self.recentBoysSectionTitle = "Boys Hockey Games"
        
        self.recentBoysSectionSearchID = 69388
        
        
        self.recentSectionTitle = "Recent Games"
        
        self.recentSectionSearchID = 68492
        
        self.buttonsSectionTitle = "Our Favorite Games of the Year"
        
        
        self.buttonsSectionType = SectionType.buttonWithTitle

         self.buttons.append(Button(factory:featuredButtonFactory()))
        
        self.buttons.append(Button(factory:featured2ButtonFactory()))
        
         self.buttons.append(Button(factory:featured3ButtonFactory()))
        
      //  self.buttons.append(Button(factory:featuredButtonFactory()))
        
        self.sliderImages = [#imageLiteral(resourceName: "hockey-1")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular, CategoryOrder.button, CategoryOrder.boys, CategoryOrder.girls]
        
    }
    
}

class swimmingFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Swimming"
        
        self.popularSectionTitle = "Most Viewed Swimming Videos"
        
        self.popularSectionSearchID = 69532
        
        
        
        
        self.recentSectionTitle = "Recent Swimming Videos"
        
        self.recentSectionSearchID = 69320
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "swimming-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}

class softballFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Softball"
        
        self.popularSectionTitle = "Most Viewed Softball Videos"
        
        self.popularSectionSearchID = 69203
        
        
        
        
        self.recentSectionTitle = "Recent Softball Games"
        
        self.recentSectionSearchID = 68774
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "softball")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}

class lacrosseFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Lacrosse"
        
  

        
        self.recentSectionTitle = "Recent Lacrosse Videos"
        
        self.recentSectionSearchID = 69263
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "swimming-header")]
        
        self.categoryOrder = [CategoryOrder.recent]
        
    }
    
}


class gymnasticsFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "Gymnastics"
        
       
        
        
        
        
        self.recentSectionTitle = "Recent Swimming Videos"
        
        self.recentSectionSearchID = 69325
        
        
        
      
        
        self.categoryOrder = [CategoryOrder.recent]
        
    }
    
}

class meetingsFactorySettings: CategoryFactorySettings {
    
    
    override init() {
        
        super.init()
        
        self.categoryTitle = "City Meetings"
        
        self.popularSectionTitle = "City Government"
        
        self.popularSectionSearchID = 52966
        
        self.popularSectionDisplayCount = 15
        
     
        
        self.featuredSectionTitle = "School Districts"
        
        self.featuredSectionSearchID = 67200
        
        self.featuredSectionDisplayCount = 20
        
     
        
        self.buttonsSectionTitle = "City Government"
        self.buttonsSectionType = SectionType.buttonWithTitle
        
        
         self.buttons.append(Button(factory:nsccMeetingsButtonFactory()))
        
         self.buttons.append(Button(factory:saintMeetingsButtonFactory()))
         self.buttons.append(Button(factory:moundsMeetingsButtonFactory()))
        
        
        
        self.buttonsSecondSectionType = SectionType.buttonWithTitle
        
        
        self.buttonsSecondTitle = "School Districts"
        
        
        self.buttonsSecond.append(Button(factory:ardenMeetingsButtonFactory()))
        

         self.buttonsSecond.append(Button(factory:falconMeetingsButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:lauderdaleMeetingsButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:canadaMeetingsButtonFactory()))
        
    
        
  
        
        
        self.buttonsThirdSectionType = SectionType.buttonNoTitle
        
        self.buttonsThird.append(Button(factory:moundsViewMeetingsButtonFactory()))
        
        self.buttonsThird.append(Button(factory:northMeetingsButtonFactory()))
        
        
        self.buttonsThird.append(Button(factory:rosevilleMeetingsButtonFactory()))
        
        
        self.buttonsThird.append(Button(factory:saintAnthonyMeetingsButtonFactory()))
      
        
        self.sliderImages = [#imageLiteral(resourceName: "meetings-header")]
        
        self.categoryOrder = [CategoryOrder.button, CategoryOrder.buttonSecond, CategoryOrder.buttonThird]
        
    }
    
}

class programsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "programs-header")
        
        self.title = "Programs"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: programsFactorySettings()))
        
    }
    
}





class communityButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "community-header")
        
        self.title = "Community"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: communityFactorySettings()))
        
    }
    
}

class meetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "meetings-header")
        
        self.title = "Meetings"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: meetingsFactorySettings()))
        
    }
    
}

class nsccMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "nscc-16-9")
        
        self.title = "NSCC/NSAC Meetings"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}

class moundsMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "mvsd")
        
        self.title = "Mounds View Meetings"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}

class saintMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "sasd-16-9")
        
        self.title = "Saint Anthony/New Brighton Meetings"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}


class ardenMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "ah-16-9")
        
        self.title = "Arden Hills"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}

class falconMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "fh-16-9")
        
        self.title = "Falcon Heights"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}

class lauderdaleMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "ld-16-9")
        
        self.title = "Lauderdale"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}

class canadaMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "lc-16-9")
        
        self.title = "Little Canada"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}


class moundsViewMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "mv-16-9")
        
        self.title = "Mounds View"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}

class northMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "no-16-9")
        
        self.title = "North Oaks"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}

class rosevilleMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "rv-16-9")
        
        self.title = "Roseville"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
    }
    
}


class saintAnthonyMeetingsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "sav-16-9")
        
        self.title = "Saint Anthony"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = nil
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
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
        
       self.recentBoysSectionSearchID = 71296
        
       // self.recentBoysSectionSearchID = 66603
        
        self.recentBoysSectionDisplayCount = 10
        
        self.featuredSectionTitle = "Community Favorites"
        
        self.featuredSectionSearchID = 71301
        
        self.featuredSectionDisplayCount = 20
        
        self.recentSectionTitle = "Basketball Season"
        
        self.recentSectionSearchID = 69113
        
        self.recentSectionDisplayCount = 15
        
        self.buttonsSectionTitle = "Browse By Sport"
        
         self.buttonsSectionType = SectionType.buttonWithTitle
        
        self.buttons.append(Button(factory:hockeyButtonFactory()))
        
        self.buttons.append(Button(factory:baseballButtonFactory()))
        
        
          self.buttons.append(Button(factory:footballButtonFactory()))
        
        self.buttons.append(Button(factory:volleyballButtonFactory()))
        
        self.buttons.append(Button(factory:soccerButtonFactory()))
        
        self.buttons.append(Button(factory:swimmingButtonFactory()))
        
        
         self.buttonsSecondSectionType = SectionType.buttonNoTitle
        
            self.buttonsSecond.append(Button(factory:aboutButtonFactory()))
      
        self.buttonsSecond.append(Button(factory:programsButtonFactory()))
        self.buttonsSecond.append(Button(factory:communityButtonFactory()))
       
           self.buttonsSecond.append(Button(factory:meetingsButtonFactory()))
          self.buttonsSecond.append(Button(factory:scheduleButtonFactory()))
     
        
   
    
        
        self.sliderImages = [#imageLiteral(resourceName: "santa-header"), #imageLiteral(resourceName: "slide-basketball-header"), #imageLiteral(resourceName: "slide-baskketball1-header"), #imageLiteral(resourceName: "slide-meeting-header")]
        
        self.categoryOrder = [CategoryOrder.popular, CategoryOrder.recent, CategoryOrder.button,  CategoryOrder.boys, CategoryOrder.girls,  CategoryOrder.buttonSecond, CategoryOrder.featured]
        
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

class featuredButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.video
        
        self.image = #imageLiteral(resourceName: "defaultPhoto")
        
        self.title = "RAHS Girls Hockey Roseville v Edina"
        
        self.imageOverlay = "RAHS Girls Hockey Roseville v Edina"
        
        self.page = nil
        
        self.videoID = 8469
        
        self.category = nil
        
    }

}

class featured2ButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.video
        
        self.image = #imageLiteral(resourceName: "defaultPhoto")
        
        self.title = "Boys Hockey Roseville v Woodbury"
        
        self.imageOverlay = "Boys Hockey Roseville v Woodbury"
        
        self.page = nil
        
        self.videoID = 9936
        
        self.category = nil
        
    }
    
}

class featured3ButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.video
        
        self.image = #imageLiteral(resourceName: "defaultPhoto")
        
        self.title = "Section Boys Hockey Roseville v WBL"
        
        self.imageOverlay = "Section Boys Hockey Roseville v WBL"
        
        self.page = nil
        
        self.videoID = 10021
        
        self.category = nil
        
    }
    
}


class footballButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "football-header")
        
        self.title = "Football"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: footballFactorySettings()))
        
        
        
    }
    
}



class hockeyButtonFactory: ButtonFactory {
    
    override init() {
        
       super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "hockey-1")
        
        self.title = "Hockey"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: hockeyFactorySettings()))
        
        
        
    }
    
}




class aboutButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.page
        
        self.image = #imageLiteral(resourceName: "about-header")
        
        self.title = "About CTV"
        
        self.imageOverlay = nil
        
        self.page = "About"
        
        
        
    }
    
}


class volleyballButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "volleyball-header")
        
        self.title = "Volleyball"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: volleyballFactorySettings()))
        
    }
    
}
class scheduleButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.webPage
        
        self.image = #imageLiteral(resourceName: "schedule-header")
        
        self.title = "Schedule"
        
        self.imageOverlay = nil
        
        self.webURL = URL(string: "http://www.ctv15.org/schedules/class-schedule#year=2016&month=12&day=13&view=month")
        

        
    }
    
}


class soccerButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "soccer-header")
        
        self.title = "Soccer"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: soccerFactorySettings()))
        
    }
    
}

class swimmingButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "swimming-header")
        
        self.title = "Swimming"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: swimmingFactorySettings()))
        
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
        
        let sectionType = settings.buttonsSectionType
        
        let sectionTitle = settings.buttonsSectionTitle
        
        
        
        let searchID: Int?  = nil
        
        let videoList: [Int]? = nil
        
        var buttons = settings.buttons
        
      
     
        
   
        
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType!, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: nil, images: images)
        
        return section
        
    }
    
    
    internal func addButtonsSecond() -> Section {
        
        let sectionType = settings.buttonsSecondSectionType
        let sectionTitle = settings.buttonsSecondTitle
        
        let searchID: Int?  = nil
        
        let videoList: [Int]? = nil
        
        var buttons = settings.buttonsSecond
        

        
     
        
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType!, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: nil, images: images)
        
        return section
        
    }
    
    
    internal func addButtonsThird() -> Section {
        
        let sectionType = settings.buttonsThirdSectionType
        let sectionTitle = settings.buttonsThirdTitle
        
        let searchID: Int?  = nil
        
        let videoList: [Int]? = nil
        
        var buttons = settings.buttonsThird
        
        
        
        
        
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType!, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, buttons: buttons, displayCount: nil, images: images)
        
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
                
            case CategoryOrder.buttonSecond:
                
                createButtonSectionSecond()
                
            case CategoryOrder.buttonThird:
                
                createButtonSectionThird()
                
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



