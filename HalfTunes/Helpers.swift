//
//  Helpers.swift
//  CTV App
//
//  Created by William Ogura on 3/1/17.
//
//

import Foundation
import UIKit


extension UIView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
}



extension UIImage {
    
    
    
    func cropBottomImage(image: UIImage) -> UIImage {
        
        let height = CGFloat(image.size.height / 2)
        
        let heightFromBottom = CGFloat(image.size.height / 3.07)
        
        let rect = CGRect(x: 0, y: image.size.height - height - heightFromBottom , width: image.size.width, height: height)
        
        return cropImage(image: image, toRect: rect)
    }
    
    
    
    func cropEventImage() -> UIImage {
        
        let height = CGFloat(self.size.height / 2)
        
        let heightFromBottom = CGFloat(self.size.height / 3.07)
        
        let rect = CGRect(x: 0, y: self.size.height - height - heightFromBottom , width: self.size.width, height: height)
        
        return cropImage(image: self, toRect: rect)
    }
    
    
    
    
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        
        return croppedImage
    }
    
    
    
    
    
    
}



func convertStringToDate(dateString: String) -> Date {
    
    
    
    let dateFormatter = DateFormatter()
    
    
    
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    
    
    
    
    
    var date = dateFormatter.date( from: dateString)
    
    
    if (date == nil) {
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        
        
        
        
        date = dateFormatter.date( from: dateString)
        
        
    }
    return date!
    
    
    
}






extension Date {
    
    func convertStringToDate(dateString: String) -> Date {
        
        let strTime = dateString
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        dateFormatter.timeZone = NSTimeZone(name: "America/Chicago") as TimeZone!
        
        
        
        
        
        
        
        let string = strTime
        
        let date = dateFormatter.date(from: string)
        
        return date!
        
    }
    
    
    func convertDateToString() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        dateFormatter.timeZone = NSTimeZone(name: "America/Chicago") as TimeZone!
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let timeString = dateFormatter.string(from: self)
        
        return timeString
        
    }
    
    
    func convertDateToTimeString() -> String {
        
        
        
        
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        dateFormatter.dateFormat = "h:mm a"
        
        
        let timeString = dateFormatter.string(from: self)
        
        
        return timeString
        
    }
    
    
    func convertEventDateToString() -> String {
        
        
        
        
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let timeString = dateFormatter.string(from: self)
        
        
        return timeString
        
    }
    
    
    func checkIfDateTimeIsTomorrow() -> Bool {
        
        let calendar = NSCalendar.autoupdatingCurrent
        
        if (calendar.isDateInTomorrow(self)) {
            
            return true
            
        }
        
        return false
        
    }
    
    
    func checkIfDateTimeIsToday() -> Bool {
        
        let calendar = NSCalendar.autoupdatingCurrent
        
        if (calendar.isDateInToday(self)) {
            
            
            
            return true
            
        }
        
        return false
        
    }
    
    
    func checkIfDateTimeIsNow() -> Bool {
        
        let calendar = NSCalendar.autoupdatingCurrent
        
        if (calendar.isDateInToday(self)) {
            
            
            if(self.timeIntervalSinceNow < 1800) {
                
                return true
                
                
            }
            
            
        }
        
        return false
        
    }

    
}

/* usage
 
 let array = [1, 2, 3]
 
 for index in -20...20 {
 if let item = array[safe: index] {
 print(item)
 }
 }
 
 */


extension Collection where Indices.Iterator.Element == Index {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    
    subscript (safe index: Index) -> Generator.Element? {
        
        return indices.contains(index) ? self[index] : nil
        
    }
}

