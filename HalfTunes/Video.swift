//
//  Video.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//
//

import Foundation

import UIKit

import MediaPlayer


open class Video: NSObject, NSCoding {
    
    var title: String?
    
    var fileName: Int?
    
    var sourceUrl: String?
    
    var thumbnail: UIImage?
    
    var comments: String?
    
    var eventDate: Date?
    
    var isEvent: Bool?
    
    
    var endDate: Date?
    
    var thumbnailUrl: NSURL?
    
    var id: Int?
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("videos")
    
    // MARK: Types
    
    struct PropertyKey {
        
        static let titleKey = "title"
        
        static let thumbnailKey = "thumbnail"
        
        static let fileNameKey = "fileName"
        
        static let sourceUrlKey = "sourceUrl"
        
        static let commentsKey = "comments"
        
        static let eventDateKey = "eventDate"
        
        static let thumbnailUrlKey = "thumbnailUrl"
        
        static let isEventKey = "isEvent"
        
        static let endDateKey = "endDate"
        
        static let idKey = "id"
        
        
        
    }
    
    // MARK: Initialization
    
    
    init?(title: String, thumbnail: UIImage?,fileName: Int?, sourceUrl: String?, comments: String, eventDate: Date, thumbnailUrl: NSURL?, id: Int?, isEvent: Bool?, endDate: Date?) {
        
        // Initialize stored properties.
        
        super.init()
        
        self.title = title
        
        self.thumbnail = thumbnail
        
        self.fileName = fileName
        
        self.sourceUrl = sourceUrl
        
        self.comments = comments
        
        self.eventDate = eventDate
        
        self.thumbnailUrl = thumbnailUrl
        
        self.id = id
        
        self.isEvent = isEvent
        
        self.endDate = endDate
        
        var str = title
        
        var newString = ""
        
        let suffix = String(describing: str.characters.suffix(6))
        
        if suffix.contains("-") {
            
            var splitArray = str.components(separatedBy: " ")
            
            if(splitArray.last?.contains("-"))! {
                
                let count = splitArray.count
                
                splitArray[count - 1].removeAll()
                
                for elements in splitArray {
                    
                    newString += (elements + " ")
                    
                }
                
                newString = newString.trimmingCharacters(in: .whitespacesAndNewlines)
                
            }
            
        }
        
        if(newString != "") {
            
            self.title = (newString)
        }
        
        // Initialization should fail if there is no title.
        
        if title.isEmpty {
            
            return nil
            
        }
        
    }
    
    
    func setEndDate(date: Date) {
        
        self.endDate = date
        
        
    }
    
    func getStartDate() -> Date? {
        
        return self.eventDate
        
    }
    
    func getEndDate() -> Date? {
        
        return self.endDate
        
    }
    
    func getIsEvent() -> Bool {
        
        if(self.isEvent != nil) {
            
        return self.isEvent!
            
        } else {
            
            return false
        }
        
    }
    
    func hasThumbnailUrl() -> Bool {
        
        if(self.thumbnailUrl != nil) {
            
            return true
        } else {
            
            return false
        }
        
    }
    
    
    func generateThumbnailUrl() {
        
        var thumbnail : String?
        
        var url : NSURL?
        
        if(self.fileName != nil ) {
            
            thumbnail = search.searchThumbnail(self.fileName!)
            
            let escapedString = thumbnail!.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            
            
            url = NSURL(string: escapedString! )
            
            self.thumbnailUrl = url
            
            
        }
        
    }
    
    
    open func generateThumbnail()  {
        
        var tempThumb: UIImage
        
        
        
        do {
            
            let asset = AVURLAsset(url: URL(string: self.sourceUrl!)!, options: nil)
            
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            
            imgGenerator.appliesPreferredTrackTransform = true
            
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(5, 1), actualTime: nil)
            
            tempThumb = UIImage(cgImage: cgImage)
            
            self.thumbnail = tempThumb
            
            // lay out this image view, or if it already exists, set its image property to uiImage
            
        } catch let error as NSError {
            
            print("Error generating thumbnail: \(error)")
            
            
            self.thumbnail = nil
            
        }
        
        
        
        
    }
    
    // MARK: NSCoding
    
    open func encode(with aCoder: NSCoder) {
        
        aCoder.encode(title, forKey: PropertyKey.titleKey)
        
        aCoder.encode(thumbnail, forKey: PropertyKey.thumbnailKey)
        
        aCoder.encode(fileName, forKey: PropertyKey.fileNameKey)
        
        aCoder.encode(sourceUrl, forKey: PropertyKey.sourceUrlKey)
        
        aCoder.encode(comments, forKey: PropertyKey.commentsKey)
        
        aCoder.encode(eventDate, forKey: PropertyKey.eventDateKey)
        
        aCoder.encode(isEvent, forKey: PropertyKey.isEventKey)
        
        
        
        aCoder.encode(thumbnailUrl, forKey: PropertyKey.thumbnailUrlKey)
        
        aCoder.encode(id, forKey: PropertyKey.idKey)
        
        aCoder.encode(endDate, forKey: PropertyKey.endDateKey)
        
        
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObject(forKey: PropertyKey.titleKey) as! String
        
        let fileName = aDecoder.decodeObject(forKey: PropertyKey.fileNameKey) as? Int
        
        let sourceUrl = aDecoder.decodeObject(forKey: PropertyKey.sourceUrlKey) as! String
        
        let comments = aDecoder.decodeObject(forKey: PropertyKey.commentsKey) as! String
        
        let eventDate = aDecoder.decodeObject(forKey: PropertyKey.eventDateKey) as! Date
        
        let endDate = aDecoder.decodeObject(forKey: PropertyKey.endDateKey) as? Date
        
        
        let thumbnailUrl =  aDecoder.decodeObject(forKey: PropertyKey.thumbnailUrlKey) as? NSURL
        
        let isEvent =  aDecoder.decodeObject(forKey: PropertyKey.isEventKey) as? Bool
        
        let id =  aDecoder.decodeObject(forKey: PropertyKey.idKey) as? Int
        
        
        let thumbnail = aDecoder.decodeObject(forKey: PropertyKey.thumbnailKey) as? UIImage
        
        // Must call designated initializer.
        
        self.init(title: title, thumbnail: thumbnail, fileName: fileName, sourceUrl: sourceUrl, comments: comments, eventDate: eventDate, thumbnailUrl: thumbnailUrl, id: id, isEvent: isEvent, endDate: endDate)
        
    }
    
}
