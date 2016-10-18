//
//  JSON.swift
//  HalfTunes
//
//  Created by William Ogura on 7/20/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
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
        
        
        if(("comments" <~~ json) != nil) {
        
        guard let comments: String = "comments" <~~ json
            
            else { print("no comments")
                
                
                return nil }
            
            
                 self.comments = comments
        }
        
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
















