//
//  Video.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation
import UIKit



class Video: NSObject, NSCoding {
    var title: String?
    var fileName: String?
    var sourceUrl: String?
    var thumbnail: UIImage?


    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("videos")
    
    // MARK: Types
    
    struct PropertyKey {
        static let titleKey = "title"
        static let thumbnailKey = "thumbnail"
        static let fileNameKey = "fileName"
        static let sourceUrlKey = "sourceUrl"
        
    }
    
    // MARK: Initialization
    
    init?(title: String, thumbnail: UIImage?,fileName: String, sourceUrl: String) {
        // Initialize stored properties.
        self.title = title
        self.thumbnail = thumbnail
      
        self.fileName = fileName
        self.sourceUrl = sourceUrl
        
       /* Possible Image setter
        let url = NSURL(string: image.url)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        imageView.image = UIImage(data: data!)
       */
        
        
        super.init()
        
        // Initialization should fail if there is no title.
        if title.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(thumbnail, forKey: PropertyKey.thumbnailKey)
        aCoder.encodeObject(fileName, forKey: PropertyKey.fileNameKey)
        aCoder.encodeObject(sourceUrl, forKey: PropertyKey.sourceUrlKey)
        
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let fileName = aDecoder.decodeObjectForKey(PropertyKey.fileNameKey) as! String
        let sourceUrl = aDecoder.decodeObjectForKey(PropertyKey.sourceUrlKey) as! String
        
        
        // Because photo is an optional property of Video, use conditional cast.
        let thumbnail = aDecoder.decodeObjectForKey(PropertyKey.thumbnailKey) as? UIImage
        
   
        
        
        
        // Must call designated initializer.
        self.init(title: title, thumbnail: thumbnail, fileName: fileName, sourceUrl: sourceUrl )
    }
    
}