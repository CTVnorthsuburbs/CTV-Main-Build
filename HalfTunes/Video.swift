//
//  Video.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit

import MediaPlayer

public func getSampleVideos() -> [Video] {
    
    var samples = [Video]()
    
    var video = Video(title: "Legion Baseball Rosetown v. Tri-City Maroon 16-07-13 Gm1", thumbnail: nil, fileName: "10581- Baseball TCM v Rosetown 16-07-13 gm1 trms.mpg", sourceUrl: "http://trms.ctv15.org/TRMSVOD/10581-Baseball-TCM-v-Rosetown-16-07-13-gm1-trms-Medium-v1.mp4")
    
    video!.generateThumbnail()
    
    samples.append(video!)
    
    video = Video(title: "Roseville High School Graduation Ceremony (RAHS) 2015-06-05 (CH14)", thumbnail: nil, fileName: "10439-RAHSGrad16-06-03.mpg", sourceUrl: "http://trms.ctv15.org/TRMSVOD/10439-RAHSGrad16-06-03-Medium-v1.mp4")
    
    video!.generateThumbnail()
    
    samples.append(video!)
    
    video = Video(title: "Softball Roseville v. Mounds View RAHS MVHS 16-04-13", thumbnail: nil, fileName: "10178- RAHS vs. MVHS Softball 16-04-13- trms.mpg", sourceUrl: "http://trms.ctv15.org/TRMSVOD/10178-RAHS-vs-MVHS-Softball-16-04-13-trms-Medium-v1.mp4")
    
    video!.generateThumbnail()
    
    samples.append(video!)

    return samples
    
}

public class Video: NSObject, NSCoding {
    
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
    
    public func generateThumbnail() {
        
        var tempThumb: UIImage
        
        do {
            
            let asset = AVURLAsset(URL: NSURL(string: self.sourceUrl!)!, options: nil)
            
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            
            imgGenerator.appliesPreferredTrackTransform = true
            
            let cgImage = try imgGenerator.copyCGImageAtTime(CMTimeMake(18, 1), actualTime: nil)
            
            tempThumb = UIImage(CGImage: cgImage)
            
            self.thumbnail = tempThumb
            
            // lay out this image view, or if it already exists, set its image property to uiImage
            
        } catch let error as NSError {
            
            print("Error generating thumbnail: \(error)")
            
        }
    
    }
    
    // MARK: NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        
        aCoder.encodeObject(thumbnail, forKey: PropertyKey.thumbnailKey)
        
        aCoder.encodeObject(fileName, forKey: PropertyKey.fileNameKey)
        
        aCoder.encodeObject(sourceUrl, forKey: PropertyKey.sourceUrlKey)
        
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        
        let fileName = aDecoder.decodeObjectForKey(PropertyKey.fileNameKey) as! String
        
        let sourceUrl = aDecoder.decodeObjectForKey(PropertyKey.sourceUrlKey) as! String
        
        // Because photo is an optional property of Video, use conditional cast.
        
        let thumbnail = aDecoder.decodeObjectForKey(PropertyKey.thumbnailKey) as? UIImage
        
        // Must call designated initializer.
        
        self.init(title: title, thumbnail: thumbnail, fileName: fileName, sourceUrl: sourceUrl )
        
    }

}