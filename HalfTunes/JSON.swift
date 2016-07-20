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
    
    public let thumbnail: Thumbnails?
    
    public init?(json: JSON) {
        show = "show" <~~ json
        vod = "vods" <~~ json
        thumbnail = "thumbnail" <~~ json
    }
    
}


public struct Vods: Decodable {
    
    
    
    public let id: Int
    
    public let url: String
    
    public let fileName: String
    
    
    public init?(json: JSON) {
        
        
        guard let id: Int = "id" <~~ json
            
            else { return nil }
        
        
        guard let url: String = "url" <~~ json
            
            else { return nil }
        
        guard let fileName: String = "fileName" <~~ json
            
            else { return nil }
        
        
        self.id = id
        
        self.url = url
        
        self.fileName = fileName
        
        
        
    }
    
}



public struct Shows: Decodable {
    
    
    public let title: String
    
    public let id: Int
    
    
    
    
    
    public init?(json: JSON) {
        
        
        guard let title: String = "title" <~~ json
            
            else { return nil }
        
        
        guard let id: Int = "id" <~~ json
            
            else { return nil }
        
        
        self.title = title
        
        self.id = id
        
        
        
        
    }
    
}

public struct Thumbnails: Decodable {
    
    
    public let thumbnail: String
    
    
    public init?(json: JSON) {
        
        
        guard let thumbnail: String = "thumbnail" <~~ json
            
            else { return nil }
        
        
        self.thumbnail = thumbnail

    }
    
}



