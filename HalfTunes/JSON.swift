//
//  JSON.swift
//  HalfTunes
//
//  Created by William Ogura on 7/20/16.

//

import Foundation


public struct Videos: Decodable {
    
    public let show: Shows?
    
    public let vod: [Vods]?
    
    public init?(json: JSON) {
        
        show = "show" <~~ json
        
        vod = "vods" <~~ json
        
        
    }
    
}


public struct SlideShow: Decodable {
    
    public let slides: [Slides]?
    
    public init?(json: JSON) {
        
        
        let slides: [Slides]? = "slides" <~~ json
        
        self.slides = slides
        
        
    }
    
}



public struct Slides: Decodable {
    
    public let title: String?
    
    public let category: String?
    
    
    
    public let imageURL: String?
    
    public let webURL: String?
    
    public let slideType: String?
    
    public let videoID: Int?
    
    public let page: String?
    
    
    public init?(json: JSON) {
        
        title = "title" <~~ json
        
        category = "category" <~~ json
        
        page = "page" <~~ json
        
        imageURL = "image" <~~ json
        
        webURL = "webURL" <~~ json
        
        slideType = "slideType" <~~ json
        
        videoID = "videoID" <~~ json
        
    }
    
}





public struct VideosResult: Decodable {
    
    public let show: [Shows]?
    
    public let vod: [Vods]?
    
    
    
    public init?(json: JSON) {
        
        show = "shows" <~~ json
        
        vod = "vods" <~~ json
        
        
        
    }
    
}

public struct AllVideos: Decodable {
    
    public let results : NSDictionary?
    
    public init?(json: JSON) {
        
        results = "savedShowSearch" <~~ json
        
    }
    
}

public struct AllVideosResults: Decodable {
    
    public let results: NSArray?
    
    public init?(json: JSON) {
        
        guard let results : NSArray = "results" <~~ json
            
            else { return nil }
        
        self.results = results
        
    }
    
}

public struct Results: Decodable {
    
    public let results: [Int]
    
    public init?(json: JSON) {
        
        guard let results : [Int] = "results" <~~ json
            
            else { return nil }
        
        self.results = results
        
    }
    
}

public struct Vods: Decodable {
    
    public let id: Int
    
    public let url: String
    
    public var fileName = ""
    
    public init?(json: JSON) {
        
        guard let id: Int = "id" <~~ json
            
            else { return nil }
        
        guard let url: String = "url" <~~ json
            
            else { return nil }
        
        
        
        if(("fileName" <~~ json) != nil) {
            
            guard let fileName: String = "fileName" <~~ json
                
                else { print("no vod fileName")
                    
                    
                    return nil }
            
            
            self.fileName = fileName
        }
        
        
        
        self.id = id
        
        self.url = url
        
        
        
    }
    
}

public struct Shows: Decodable {
    
    public let title: String
    
    public let id: Int
    
    public var comments = ""
    
    public let showThumbnail: [Int]
    
    public let date: String
    
    public init?(json: JSON) {
        
        guard let title: String = "title" <~~ json
            
            else {
                print("no title")
                return nil
                
                
                
        }
        
        guard let id: Int = "id" <~~ json
            
            else { print("no id")
                return nil }
        
        
        
        
        guard let showThumbnail: [Int] = "showThumbnails" <~~ json
            
            else {
                
                
                print("no thumbnails")
                return nil
                
        }
        
        guard let date: String = "eventDate" <~~ json
            
            else {
                
                
                print("no date")
                return nil
                
        }
        
        
        let comments : String? = "comments" <~~ json
        
        
        if(comments != nil) {
            self.comments = comments!
        }
        self.title = title
        
        self.id = id
        
        
        
        self.showThumbnail = showThumbnail
        
        self.date = date
        
    }
    
}


public struct Thumbnail: Decodable {
    
    public let thumbnail: Thumbnails?
    
    public init?(json: JSON) {
        
        guard let thumbnail: Thumbnails = "thumbnail" <~~ json
            
            else {
                
                print("JSON Thumbnail doesnt execute")
                
                return nil }
        
        self.thumbnail = thumbnail
        
        
        
    }
    
}



public struct YoutubeVideo: Decodable {
    
    public let items: [NSDictionary]?
    
    public init?(json: JSON) {
        
        guard let items:  [NSDictionary]? = "items" <~~ json
            
            else {
                
                print("JSON youtubeItems doesnt execute")
                
                return nil }
        
        self.items = items
        
    }
    
}


public struct YoutubeItems: Decodable {
    
    let id: String?
    
    let snippet: YoutubeSnippet?
    
    public init?(json: JSON) {
        self.id = "id" <~~ json
        
        self.snippet = "snippet" <~~ json
        
    }
    
}


public struct YoutubeThumbnail: Decodable {
    
    let defaultThumbnail: YoutubeDefaultThumbnail?
    
    public init?(json: JSON) {
        self.defaultThumbnail = "standard" <~~ json
        
        
        
    }
    
}

public struct YoutubeDefaultThumbnail: Decodable {
    
    let url: String?
    
    public init?(json: JSON) {
        self.url = "url" <~~ json
        
        
    }
    
}

public struct YoutubeResource: Decodable {
    
    let videoId: String?
    
    public init?(json: JSON) {
        self.videoId = "videoId" <~~ json
        
        
    }
    
}



public struct YoutubeSnippet: Decodable {
    
    
    public let title: String?
    
    public let description: String?
    
    public let thumbnail: YoutubeThumbnail?
    
    public let channelId: String?
    
    public let date: Date?
    
    public let resourceId: YoutubeResource?
    
    public init?(json: JSON) {
        
        
        
        guard let title: String = "title" <~~ json
            
            else {
                
                print("title doesnt work")
                
                return nil }
        
        guard let description: String = "description" <~~ json
            
            else {
                
                print("description not working")
                
                return nil }
        
        
        guard let thumbnail: YoutubeThumbnail = "thumbnails" <~~ json
            
            else {
                
                print("thumbnail not working")
                
                return nil }
        
        
        guard let channelId: String = "channelId" <~~ json
            
            else {
                
                print("id not working")
                
                return nil }
        
        
        guard let date: String = "publishedAt" <~~ json
            
            else {
                
                print("date not working")
                
                return nil }
        
        
        guard let resource: YoutubeResource = "resourceId" <~~ json
            
            else {
                
                print("resource not working")
                
                return nil }
        
        
        self.title = title
        
        self.description = description
        
        self.thumbnail = thumbnail
        
        self.channelId = channelId
        
        self.date = convertStringToDate(dateString: date)
        
        self.resourceId = resource
        
    }
    
}


public struct Thumbnails: Decodable {
    
    
    public let id: Int
    
    public let url: String
    
    public init?(json: JSON) {
        
        
        
        guard let id: Int = "id" <~~ json
            
            else {
                
                print("id")
                
                return nil }
        
        guard let url: String = "url" <~~ json
            
            else {
                
                print("url not working")
                
                return nil }
        
        self.url = url
        
        self.id = id
        
    }
    
}
















