//
//  CategoryButtons.swift
//  CTV App
//
//  Created by William Ogura on 1/11/17.

//

import Foundation

import UIKit


@objc(teens)
class teens: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Teens"
        
        
        self.videoType = VideoType.youtube
        
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
        
        
        
        
        
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "teens-header")]
        
        self.categoryOrder = [CategoryOrder.popular, CategoryOrder.recent, CategoryOrder.featured, CategoryOrder.boys]
        
    }
    
}

@objc(ctvyoutube)
class ctvyoutube: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "YouTube"
        
        
        self.videoType = VideoType.youtube
        
        self.popularSectionTitle = "CTV sports"
        
        self.popularSectionSearchID = 1
        
        self.popularSectionDisplayCount = 15
        
        self.popularSectionPlaylist = "PL95MWKnFfyTIbeaxDyo4bniLDsh5p2oOc"
        
        
        self.recentSectionTitle = "Irondale Sports"
        
        self.recentSectionSearchID = 2
        
        self.recentSectionDisplayCount = 15
        
        self.recentSectionPlaylist = "PL95MWKnFfyTKQIRZSfqP65Q1d8XyGB4Bm"
        
        
        self.featuredSectionTitle = "Water is Everyone's Business"
        
        self.featuredSectionSearchID = 3
        
        self.featuredSectionDisplayCount = 15
        
        self.featuredSectionPlaylist = "PL95MWKnFfyTJxw0riNq0HEw4YPbEJf7-D"
        
     
        
        
        
        self.recentBoysSectionTitle = "Favorite Videos"
        
        self.recentBoysSectionSearchID = 4
        
        self.recentBoysSectionDisplayCount = 15
        
        self.recentBoysSectionPlaylist = "PL34AE5B5661B3B17A"
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "youtube-header")]
        
        self.categoryOrder = [CategoryOrder.popular, CategoryOrder.recent, CategoryOrder.featured, CategoryOrder.boys]
        
    }
    
}










@objc(baseball)

class baseball: CategoryFactorySettings {
    
    
    required init() {
        
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
        
        self.sliderImages = [#imageLiteral(resourceName: "baseball")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular,  CategoryOrder.girls]
        
    }
    
}


@objc(graduations)
class graduations: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Graduations"
        
     
        
        self.recentSectionTitle = "Recent Graduations"
        
        self.recentSectionSearchID = 76916
        
        self.sliderImages = [#imageLiteral(resourceName: "mobile-grad-slide")]
        
        self.categoryOrder = [CategoryOrder.recent]
        
    }
    
}


@objc(parades)
class parades: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Parades"
        
        
        
        self.recentSectionTitle = "Recent Parades"
        
        self.recentSectionSearchID = 76916
        
        self.sliderImages = [#imageLiteral(resourceName: "mobile-roseparade")]
        
        self.categoryOrder = [CategoryOrder.recent]
        
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


@objc(programs)
class programs: CategoryFactorySettings {
    
    
    required init() {
        
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
        
        self.recentSectionDisplayCount = 15
        
        self.sliderImages = [#imageLiteral(resourceName: "programs-header")]
        
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.featured,   CategoryOrder.girls,  CategoryOrder.popular, CategoryOrder.boys]
        
    }
    
}




@objc(football)
class football: CategoryFactorySettings {
    
    
    required init() {
        
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

@objc(volleyball)

class volleyball: CategoryFactorySettings {
    
    
    required init() {
        
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

@objc(basketball)

class basketball: CategoryFactorySettings {
    
    
    required init() {
        
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
        
        self.sliderImages = [#imageLiteral(resourceName: "basketball-header")]
        
        
     
        self.categoryOrder = [CategoryOrder.recent, CategoryOrder.popular,  CategoryOrder.boys, CategoryOrder.girls]
        
        
        
    }
    
}

@objc(soccer)

class soccer: CategoryFactorySettings {
    
    
    required init() {
        
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

@objc(hockey)

class hockey: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Hockey"
        
        self.popularSectionTitle = "Popular Games"
        
        self.popularSectionSearchID = 68483
        
        self.popularSectionDisplayCount = 15
        
        self.recentGirlsSectionTitle = "Girls Games"
        
        self.recentGirlsSectionSearchID = 68489
        
        self.recentBoysSectionTitle = "Boys Hockey Games"
        
        self.recentBoysSectionSearchID = 69388
        
        
        self.recentSectionTitle = "Recent Games"
        
        self.recentSectionSearchID = 68492
        
        self.recentSectionDisplayCount = 15
        
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

@objc(swimming)

class swimming: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Swimming"
        
        self.popularSectionTitle = "Most Viewed Swimming Videos"
        
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
        
        self.popularSectionTitle = "Most Viewed Softball Videos"
        
        self.popularSectionSearchID = 69203
        
        
        
        
        self.recentSectionTitle = "Recent Softball Games"
        
        self.recentSectionSearchID = 68774
        
        
        
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
        
        
        
        self.sliderImages = [#imageLiteral(resourceName: "lacrosse-header")]
        
        self.categoryOrder = [CategoryOrder.recent]
        
    }
    
}

@objc(gymnastics)

class gymnastics: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Gymnastics"
        
        
        
        
        
        
        self.recentSectionTitle = "Recent Gymnastics Videos"
        
        self.recentSectionSearchID = 69325
        
        
          self.sliderImages = [#imageLiteral(resourceName: "gymnastics-header")]
        
        
        self.categoryOrder = [CategoryOrder.recent]
        
    }
    
}

@objc(meetings)

class meetings: CategoryFactorySettings {
    
    
    required init() {
        
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

@objc(home)

class home: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Home"
        
        self.popularSectionTitle = "New & Noteworthy"
        
       // self.popularSectionSearchID = 52966
        
        self.popularSectionSearchID = 76921
        
        
        
        self.popularSectionDisplayCount = 15
        
        self.recentGirlsSectionTitle = "Concerts"
        
        self.recentGirlsSectionSearchID = 67318
        
        self.recentGirlsSectionDisplayCount = 15
        
        self.recentBoysSectionTitle = "Local News"
        
        self.recentBoysSectionSearchID = 71296
        
        // self.recentBoysSectionSearchID = 66603
        
        self.recentBoysSectionDisplayCount = 15
        
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
        self.buttons.append(Button(factory:basketballButtonFactory()))
        
        self.buttons.append(Button(factory:footballButtonFactory()))
        
        self.buttons.append(Button(factory:volleyballButtonFactory()))
        
        self.buttons.append(Button(factory:soccerButtonFactory()))
        
        self.buttons.append(Button(factory:swimmingButtonFactory()))
        
        
        self.buttonsSecondSectionType = SectionType.buttonWithTitle
        
        self.buttonsSecondTitle = "Browse By"
        
        self.buttonsSecond.append(Button(factory:communityButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:meetingsButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:live1ButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:teenButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:aboutButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:ctvYouTubeButtonFactory()))
        
        self.buttonsSecond.append(Button(factory:programsButtonFactory()))
      
        self.buttonsSecond.append(Button(factory:scheduleButtonFactory()))
        
        
        
        /*
        
        self.sliderImages = [#imageLiteral(resourceName: "santa-header"), #imageLiteral(resourceName: "slide-basketball-header"), #imageLiteral(resourceName: "slide-baskketball1-header"), #imageLiteral(resourceName: "slide-meeting-header")]
        
        
        
        var slide1 = Slide(slideType: ButtonType.video, searchID: nil, videoList: [11193], page: nil, category: nil, image: #imageLiteral(resourceName: "santa-header"), title: "Letters to Santa", webURL: nil)
        
        var slide2 = Slide(slideType: ButtonType.category, searchID: nil, videoList: nil, page: nil, category: basketballFactorySettings(), image:#imageLiteral(resourceName: "slide-basketball-header"), title: "Basketball", webURL: nil)
        
        var slide3 = Slide(slideType: ButtonType.category, searchID: nil, videoList: nil, page: nil, category: meetingsFactorySettings(), image: #imageLiteral(resourceName: "slide-meeting-header"), title: "Meetings", webURL: nil)
        
        
        
        // var slide4 = Slide(slideType: ButtonType.webPage, searchID: nil, videoList: nil, page: nil, category: nil, image: #imageLiteral(resourceName: "slide-baskketball1-header"), title: "Basketball", webURL: URL(string: "http://www.ctvnorthsuburbs.org/content/pdfs/job-ptr.pdf"))
        
        
        // var slide4 = Slide(slideType: ButtonType.page, searchID: nil, videoList: nil, page: "About", category: nil, image: #imageLiteral(resourceName: "slide-baskketball1-header"), title: "About CTV", webURL: nil)
        
        var slide4 = Slide(slideType: ButtonType.category, searchID: nil, videoList: nil, page: nil, category: basketballFactorySettings(), image:#imageLiteral(resourceName: "slide-baskketball1-header"), title: "Basketball", webURL: nil)
        
        self.slides.append(slide1)
        
        self.slides.append(slide2)
        
        self.slides.append(slide3)
        
        self.slides.append(slide4)
 
 */
        
        //   self.categoryOrder = [CategoryOrder.popular, CategoryOrder.recent, CategoryOrder.button,  CategoryOrder.boys, CategoryOrder.girls,  CategoryOrder.buttonSecond, CategoryOrder.featured]
        
        self.categoryOrder = [CategoryOrder.popular, CategoryOrder.recent, CategoryOrder.buttonSecond, CategoryOrder.boys, CategoryOrder.button,   CategoryOrder.girls,   CategoryOrder.featured]
        
    }
    
}

