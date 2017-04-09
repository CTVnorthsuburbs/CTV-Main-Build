//
//  CategoryButtonFactories.swift
//  CTV App
//
//  Created by William Ogura on 1/11/17.
// 
//

import Foundation

import UIKit



class programsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "programs-header")
        
        self.title = "Programs"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: programs()))
        
    }
    
}




class paradesButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "parades-header")
        
        self.title = "Parades"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: parades()))
        
    }
    
}

class concertsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "concerts")
        
        self.title = "Concerts"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: concerts()))
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: community()))
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: meetings()))
        
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
        
      //  self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=86")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/typeview.php?regionid=85&amp;typeid=41")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/typeview.php?regionid=80&amp;typeid=41")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=57")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=97")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=58")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=59")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=60")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=62")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=78")
        
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
        
        self.webURL = URL(string: "http://webstreaming.ctv15.org/regionview.php?regionid=64")
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: teens()))
        
        
        
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

class ctvYouTubeButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "youtube-header")
        
        self.title = "CTV YouTube"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: ctvyoutube()))
        
        
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: baseball()))
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: basketball()))
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: football()))
        
        
        
    }
    
}


class gymnasticsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "gymnastics-header")
        
        self.title = "Gymnastics"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: gymnastics()))
        
        
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: hockey()))
        
        
        
    }
    
}



class lacrosseButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "lacrosse-header")
        
        self.title = "Lacrosse"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: lacrosse()))
        
        
        
    }
    
}


class sportsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "sports")
        
        self.title = "Sports"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: sports()))
        
        
        
    }
    
}

class newsButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "news")
        
        self.title = "News"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: news()))
        
        
        
    }
    
}



class softballButtonFactory: ButtonFactory {
    
    override init() {
        
        super.init()
        
        self.type = ButtonType.category
        
        self.image = #imageLiteral(resourceName: "softball")
        
        self.title = "Softball"
        
        self.imageOverlay = nil
        
        self.page = nil
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: softball()))
        
        
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: volleyball()))
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: soccer()))
        
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
        
        self.category = Category(categoryFactory: CategoryFactory(factorySettings: swimming()))
        
    }
    
}





