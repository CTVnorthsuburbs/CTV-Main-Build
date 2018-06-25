//
//  CategoryButtons.swift
//  CTV App
//
//  Created by William Ogura on 1/11/17.

//

import Foundation

import UIKit


@objc(sports)
class sports: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Sports"
  
        self.recentSectionTitle = "Recent Sports"
        
        self.recentSectionSearchID = 85458
        
           self.recentSectionDisplayCount = 20
        
        
        
        
        self.popularSectionTitle = "Popular Sports"
        
        self.popularSectionSearchID = 90309
        
        self.popularSectionDisplayCount = 20
        
        
        
        self.buttonsSectionTitle = "Browse By Sport"
        
        self.buttonsSectionType = SectionType.buttonWithTitle
        
        self.buttons.append(Button(factory:baseballButtonFactory()))
        
        self.buttons.append(Button(factory:basketballButtonFactory()))
        
        self.buttons.append(Button(factory:footballButtonFactory()))
        
        self.buttons.append(Button(factory:gymnasticsButtonFactory()))
        
        
        self.buttons.append(Button(factory:hockeyButtonFactory()))
        
        self.buttons.append(Button(factory:lacrosseButtonFactory()))
        
        self.buttons.append(Button(factory:soccerButtonFactory()))
        
        
        self.buttons.append(Button(factory:softballButtonFactory()))
        
        
        
        self.buttons.append(Button(factory:swimmingButtonFactory()))
        
        self.buttons.append(Button(factory:volleyballButtonFactory()))
        
        
        self.sliderImages = [#imageLiteral(resourceName: "sports")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.button, CategoryOrder.popular]
        
    }
    
}



@objc(graduations)
class graduations: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Graduations"
        
        self.popularSectionTitle = "Recent Graduations"
        
        self.popularSectionSearchID = 76916
        
        self.popularSectionDisplayCount = 15
        

        self.sliderImages = [#imageLiteral(resourceName: "graduations")]
        
        self.categoryOrder = [CategoryOrder.popular]
        
    }
    
}





@objc(home)

class home: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Home"
        
        
        self.upcomingSectionTitle = "Upcoming Live Events"
        
        self.upcomingSectionSearchID = 85123
        
        self.upcomingSectionDisplayCount = 20
        
        
        self.popularSectionTitle = "Recent Events"
        
        
        
        self.popularSectionSearchID = 85123
        
        self.popularSectionDisplayCount = 15
        
        
        self.recentGirlsSectionTitle = "Concerts"
        
        self.recentGirlsSectionSearchID = 67318
        
        self.recentGirlsSectionDisplayCount = 15
        
        self.recentBoysSectionTitle = "Recent Sports"
        
        self.recentBoysSectionSearchID = 85458
        
      

        self.recentBoysSectionDisplayCount = 15
        
        self.featuredSectionTitle = "Community Favorites"
        
        self.featuredSectionSearchID = 71301
        
        self.featuredSectionDisplayCount = 20
        
        self.recentSectionTitle = "Featured Programs"
        
        self.recentSectionSearchID = 88862
        
        self.recentSectionDisplayCount = 15
        
     
        
      
        
        
        
        self.buttonsSquareSection = SectionType.squareButtonWithTitle
        
        self.buttonsSquareTitle = "Browse By"
        
         self.buttonsSquare.append(Button(factory:meetingsButtonFactory()))
          self.buttonsSquare.append(Button(factory:sportsButtonFactory()))
         self.buttonsSquare.append(Button(factory:newsButtonFactory()))
        
        self.buttonsSquare.append(Button(factory:programsButtonFactory()))
        
    //    self.buttonsSecond.append(Button(factory:communityButtonFactory()))
        
       
      self.buttonsSquare.append(Button(factory:concertsButtonFactory()))
        
        self.buttonsSquare.append(Button(factory:teenButtonFactory()))
        
         self.buttonsSquare.append(Button(factory:ctvYouTubeButtonFactory()))
        
        self.buttonsSquare.append(Button(factory:aboutButtonFactory()))
        
       
        
       
        
      //  self.buttonsSecond.append(Button(factory:scheduleButtonFactory()))
        
        
        
        self.categoryOrder = [CategoryOrder.upcoming, CategoryOrder.popular,  CategoryOrder.square, CategoryOrder.recent, CategoryOrder.boys]
        
    }
    
}





@objc(teens)
class teens: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Teens"
        
        
        self.videoType = VideoType.youtube
        
        self.recent2SectionTitle = "Uploads"
        
        self.recent2SectionSearchID = 2
        
        self.recent2SectionDisplayCount = 15
        
        self.recent2SectionPlaylist = "UUItaxOh-FCAiD2Hjqt1KlEw"
        
        
        
        
       
        
        
        
        self.popularSectionTitle = "CreaTV Episodes"
        
        self.popularSectionSearchID = 1
        
        self.popularSectionDisplayCount = 15
        
        self.popularSectionPlaylist = "PLc4OSwdRXG_KJwyC0WFroPmqwA67PAhZI"
        
        
        self.recentSectionTitle = "Summers @ the Station"
        
        self.recentSectionSearchID = 2
        
        self.recentSectionDisplayCount = 15
        
        self.recentSectionPlaylist = "PLc4OSwdRXG_JCNGQSDREaQqAyYOc8Yfbd"
        
        
        
        
        self.featuredSectionTitle = "Teens Interns"
        
        self.featuredSectionSearchID = 3
        
        self.featuredSectionDisplayCount = 15
        
        self.featuredSectionPlaylist = "PLc4OSwdRXG_LFv2E0tko6PzweN-GQ1KB1"
 
        self.recentBoysSectionTitle = "Young Lenses"
        
        self.recentBoysSectionSearchID = 4
        
        self.recentBoysSectionDisplayCount = 15
        
        self.recentBoysSectionPlaylist = "PLc4OSwdRXG_J0LTEtHVsx-zBH6sF39Nvs"
        
     
        
        

        self.sliderImages = [#imageLiteral(resourceName: "teens-header-1")]
        
        self.categoryOrder = [CategoryOrder.recent2,CategoryOrder.popular, CategoryOrder.recent, CategoryOrder.featured, CategoryOrder.boys]
        
    }
    
}

@objc(ctvyoutube)
class ctvyoutube: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "YouTube"
        
        
        self.videoType = VideoType.youtube
        
        self.popularSectionTitle = "Uploads"
        
        self.popularSectionSearchID = 1
        
        self.popularSectionDisplayCount = 15
        
        self.popularSectionPlaylist = "UUwzUkowRlX6k_c5McHrcP8g"
        
        
        self.recentSectionTitle = "CTV Sports"
        
        self.recentSectionSearchID = 2
        
        self.recentSectionDisplayCount = 15
        
        self.recentSectionPlaylist = "PL95MWKnFfyTIbeaxDyo4bniLDsh5p2oOc"
        
        
        self.featuredSectionTitle = "Top Videos"
        
        self.featuredSectionSearchID = 3
        
        self.featuredSectionDisplayCount = 15
        
        self.featuredSectionPlaylist = "PL34AE5B5661B3B17A"
 
        self.recentBoysSectionTitle = "Favorite Videos"
        
        self.recentBoysSectionSearchID = 4
        
        self.recentBoysSectionDisplayCount = 15
        
        self.recentBoysSectionPlaylist = "PL34AE5B5661B3B17A"
 
        self.sliderImages = [#imageLiteral(resourceName: "youtube-header")]
        
        self.categoryOrder = [CategoryOrder.popular, CategoryOrder.featured, CategoryOrder.recent]
        
    }
    
}


@objc(baseball)

class baseball: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Baseball"
        
        self.popularSectionTitle = "Popular Baseball Games"
        
        self.popularSectionSearchID = 69173
        
        self.recentGirlsSectionTitle = "Softball Games"
        
        self.recentGirlsSectionSearchID = 69205
        
        self.recentBoysSectionTitle = "Boys Baseball Games"
        
        self.recentBoysSectionSearchID = 68492
        
        self.featuredSectionTitle = "Featured Baseball Games"
        
        self.featuredSectionSearchID = 65797
        
        self.recentSectionTitle = "Recent Baseball Games"
        
        self.recentSectionSearchID = 69188
        
        self.sliderImages = [#imageLiteral(resourceName: "baseball")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}




@objc(parades)
class parades: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Parades"

        self.recentSectionTitle = "Recent Parades"
        
        self.recentSectionSearchID = 85461
        
        self.popularSectionTitle = "Popular Parades"
        
        self.popularSectionSearchID = 90339
        
        90339
        
        self.sliderImages = [#imageLiteral(resourceName: "mobile-roseparade")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}

@objc(community)
class community: CategoryFactorySettings {
    
    
    required init() {
        
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

@objc(concerts)
class concerts: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        
        
        self.categoryTitle = "Concerts"
        

        
        self.popularSectionTitle = "Popular Concerts"
        
        self.popularSectionSearchID = 88868
        self.popularSectionDisplayCount = 20
        
        
        self.recentSectionTitle = "Recent Concerts"
        
        self.recentSectionSearchID = 67318
        
        self.recentSectionDisplayCount = 20
        
        self.sliderImages = [#imageLiteral(resourceName: "concerts")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}



@objc(news)
class news: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "News"
        
        self.popularSectionTitle = "Popular News"
        
        self.popularSectionSearchID = 90317
        
        self.popularSectionDisplayCount = 15
        
        self.recentGirlsSectionTitle = "What's Brewin'"
        
        self.recentGirlsSectionSearchID = 71346
        
        self.recentBoysSectionTitle = "Disability Viewpoints"
        
        self.recentBoysSectionSearchID = 71349
        
        self.featuredSectionTitle = "Tales of Our Cities"
        
        self.featuredSectionSearchID = 71328
        
        
        
        self.recentSectionTitle = "North Suburban Beat"
        
        self.recentSectionSearchID = 66603
        
        self.recentSectionDisplayCount = 15
        
        self.sliderImages = [#imageLiteral(resourceName: "news")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}


@objc(programs)
class programs: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Programs"
        
       
        
        self.recent2SectionTitle = "Recent Programs"
        
        self.recent2SectionSearchID = 71301
        
        self.recent2SectionDisplayCount = 20
        
        
        
        self.popularSectionTitle = "Parades"
        
        self.popularSectionSearchID = 85461
        
        self.recentGirlsSectionTitle = "What's Brewin'"
        
        self.recentGirlsSectionSearchID = 71346
        
        self.recentBoysSectionTitle = "Disability Viewpoints"
        
        self.recentBoysSectionSearchID = 71349
        
        self.featuredSectionTitle = "Tales of Our Cities"
        
        self.featuredSectionSearchID = 71328
        
        self.recentSectionTitle = "North Suburban Beat"
        
        self.recentSectionSearchID = 66603
        
        self.featured2SectionTitle = "Graduations"
        
        self.featured2SectionSearchID = 76916
        
        
        self.featured3SectionTitle = "Community Videos"
        
        self.featured3SectionSearchID = 71296
        
        
        self.recentSectionDisplayCount = 15
        
        self.sliderImages = [#imageLiteral(resourceName: "programs-header")]
        
        self.categoryOrder = [CategoryOrder.recent2, CategoryOrder.recent, CategoryOrder.featured,   CategoryOrder.girls,  CategoryOrder.popular,CategoryOrder.featured2, CategoryOrder.boys]
        
    }
    
}




@objc(football)
class football: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Football"
        
        self.popularSectionTitle = "Popular Football Games"
        
        self.popularSectionSearchID = 69223
   
        self.recentSectionTitle = "Recent Football Games"
    
        self.recentSectionSearchID = 69238
        
        self.sliderImages = [#imageLiteral(resourceName: "football-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular ]
        
    }
    
}

@objc(volleyball)

class volleyball: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Volleyball"
        
        self.popularSectionTitle = "Popular Volleyball Games"
        
        self.popularSectionSearchID = 69299
  
        
        self.recentSectionTitle = "Recent Volleyball Games"

        self.recentSectionSearchID = 69308
        
        self.sliderImages = [#imageLiteral(resourceName: "volleyball-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular ]
        
    }
    
}

@objc(basketball)

class basketball: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Basketball"
        
        self.upcomingSectionTitle = "Upcoming Events"
        
        self.upcomingSectionSearchID = 69103
        
        self.upcomingSectionDisplayCount = 20
        
  
        self.popularSectionTitle = "Popular Basketball Games"
        
        self.popularSectionSearchID = 69103
        
        
        
        self.recentGirlsSectionTitle = "Girls Basketball Games"
        
        self.recentGirlsSectionSearchID = 69419
        
        self.recentBoysSectionTitle = "Boys Basketball Games"
        
        self.recentBoysSectionSearchID = 69415
        
        
        self.recentSectionTitle = "Recent Basketball Games"
        
        self.recentSectionSearchID = 69113
        
        self.sliderImages = [#imageLiteral(resourceName: "basketball-header")]
        
        self.categoryOrder = [ CategoryOrder.recent, CategoryOrder.popular,  CategoryOrder.boys, CategoryOrder.girls]
    
    }
    
}

@objc(soccer)

class soccer: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Soccer"
        
        self.popularSectionTitle = "Popular Soccer Games"
        
        self.popularSectionSearchID = 69278
        
        
        
        
        self.recentSectionTitle = "Recent Soccer Games"
        
        self.recentSectionSearchID = 69285
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "soccer-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}

@objc(hockey)

class hockey: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Hockey"
        
        self.popularSectionTitle = "Popular Hockey Games"
        
        self.popularSectionSearchID = 68483
        
        self.popularSectionDisplayCount = 15
        
        self.recentGirlsSectionTitle = "Girls Hockey Games"
        
        self.recentGirlsSectionSearchID = 69400
        
        self.recentBoysSectionTitle = "Boys Hockey Games"
        
        self.recentBoysSectionSearchID = 69383
        
        
        self.recentSectionTitle = "Recent Hockey Games"
        
        self.recentSectionSearchID = 85876
        
        self.recentSectionDisplayCount = 15
        
    
        self.sliderImages = [#imageLiteral(resourceName: "hockey-1")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular,  CategoryOrder.boys, CategoryOrder.girls]
        
    }
    
}

@objc(swimming)

class swimming: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Swimming"
        
        self.popularSectionTitle = "Popular Swimming Videos"
        
        self.popularSectionSearchID = 69532
        
        self.popularSectionDisplayCount = 15
        
        
        self.recentSectionTitle = "Recent Swimming Videos"
        
        self.recentSectionSearchID = 69320
        
        self.recentSectionDisplayCount = 15
        
        self.sliderImages = [#imageLiteral(resourceName: "swimming-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}

@objc(softball)

class softball: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Softball"
        
        self.popularSectionTitle = "Popular Softball Games"
        
        self.popularSectionSearchID = 69278
        
        
        
        
        self.recentSectionTitle = "Recent Softball Games"
        
        self.recentSectionSearchID = 69205
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "softball")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}

@objc(lacrosse)

class lacrosse: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Lacrosse"
        
        
        
        
        self.recentSectionTitle = "Recent Lacrosse Videos"
        
        self.recentSectionSearchID = 69263
        
        
        self.popularSectionTitle = "Popular Lacrosse Videos"
        
        self.popularSectionSearchID = 90334
        
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "lacrosse-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}

@objc(gymnastics)

class gymnastics: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Gymnastics"
        
        
        
        
        
        
        self.recentSectionTitle = "Recent Gymnastics Videos"
        
        self.recentSectionSearchID = 69344
        
        
        self.popularSectionTitle = "Popular Gymnastics Videos"
        
        self.popularSectionSearchID = 90329
        
        
          self.sliderImages = [#imageLiteral(resourceName: "gymnastics-header")]
        
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular]
        
    }
    
}

@objc(meetings)

class meetings: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Meetings"
        
        self.popularSectionTitle = "City Government"
        
        self.popularSectionSearchID = 52966
        
        self.popularSectionDisplayCount = 15
        
        
        
        self.featuredSectionTitle = "School Districts"
        
        self.featuredSectionSearchID = 67200
        
        self.featuredSectionDisplayCount = 20
        
        
        
        self.buttonsSectionTitle = "School Districts"
        self.buttonsSectionType = SectionType.buttonWithTitle
        
        
        self.buttons.append(Button(factory:nsccMeetingsButtonFactory()))
        
        self.buttons.append(Button(factory:saintMeetingsButtonFactory()))
        self.buttons.append(Button(factory:moundsMeetingsButtonFactory()))
        
        
        
        self.buttonsSecondSectionType = SectionType.buttonWithTitle
        
        
        self.buttonsSecondTitle = "City Government"
        
        
        self.buttonsSecond.append(Button(factory:ardenMeetingsButtonFactory()))
        
        
        self.buttonsSecond.append(Button(factory:falconMeetingsButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:lauderdaleMeetingsButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:canadaMeetingsButtonFactory()))
        
        
        
        
        
        
       // self.buttonsThirdSectionType = SectionType.buttonNoTitle
        
        self.buttonsSecond.append(Button(factory:moundsViewMeetingsButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:northMeetingsButtonFactory()))
        
        
        self.buttonsSecond.append(Button(factory:rosevilleMeetingsButtonFactory()))
        
        
        self.buttonsSecond.append(Button(factory:saintAnthonyMeetingsButtonFactory()))
        
        
        self.sliderImages = [#imageLiteral(resourceName: "meetings-header")]
        
        self.categoryOrder = [CategoryOrder.button, CategoryOrder.buttonSecond]
        
    }
    
}





