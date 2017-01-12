//
//  CategoryButtonFactories.swift
//  CTV App
//
//  Created by William Ogura on 1/11/17.
//  Copyright © 2017 Ken Toh. All rights reserved.
//

import Foundation

import UIKit





class live1ButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.video
        
        self.image = #imageLiteral(resourceName: "live-event-header")
        
        self.title = "Live Event 1"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.videoID = 1
        
        self.category = nil
    
        
        self.webURL = URL(string: "http://wowza1.ctv15.org:1935/Live1/live/playlist.m3u8")
        
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





class baseballButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "baseball")
        
        self.title = "Baseball"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: baseballFactorySettings()))
        
    }
    
}

class basketballButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "basketball-header")
        
        self.title = "Basketball"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: basketballFactorySettings()))
        
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


class teenButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "teens-header")
        
        self.title = "CTV Teens"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: teenFactorySettings()))
        
        
        
    }
    
}

class ctvYouTubeButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "youtube-header")
        
        self.title = "CTV YouTube"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: ctvYouTubeFactorySettings()))
        
        
        
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





