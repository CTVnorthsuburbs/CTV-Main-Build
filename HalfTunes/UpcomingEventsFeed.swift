//
//  UpcomingEventsFeed.swift
//  CTV App
//
//  Created by William Ogura on 2/23/17.
//  
//


import Foundation

import UIKit


class UpcomingEventsFeed {
    

    let upcomingEventFeedURL = URL(string: "http://www.ctv15.org/index.php?option=com_obrss&task=feed&id=2:app-json-feed&format=json")
    
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    
    /// Creates the NSURL session necessary to download content from remote URL.
    
    fileprivate func getNSURLSession() -> URLSession {

        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        return defaultSession
        
    }
    
    
    func checkForUpcomingSection(category: Category) -> Section? {
        
        for section in category.sections {
            
            if(section.sectionType == SectionType.upcomingEventList) {
                
                return section
                

            }

            
        }

        return nil

        
    }

    
    func getUpcomingEventVideos(events: [Event]) -> [Video] {

        var videos = [Video]()

        for event in events {

            let video = Video(title: event.title, thumbnail: nil, fileName: 0, sourceUrl: event.liveStream, comments: "", eventDate: event.startDate, thumbnailUrl: event.image, id: 1, isEvent: true, endDate: event.endDate)

            video?.setEndDate(date: event.endDate)

            videos.append(video!)
    
        }
 
       return videos
        
        
    }

    
    
    func getUpcomingEventUpdate(category: Category) -> [Event]? {

        let section = checkForUpcomingSection(category: category)
        
        
        if(section != nil) {
            
            let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
            
            let semaphore = DispatchSemaphore(value: 0)
            
            var dataTask: URLSessionDataTask
            
            var events = [Event]()
      
            dataTask = defaultSession.dataTask(with: upcomingEventFeedURL!,  completionHandler: {
                
                data, response, error in
                
                DispatchQueue.main.async {
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    
                }
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                } else if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        
                        events = self.updateSearchResults(data)!
                        
                    } else {
                        
                        print("!!!!!!!!!!!!!!!!!!!")
                        
                    }
                    
                }
                
                semaphore.signal()
                
            })
            
            dataTask.resume()
            
            semaphore.wait(timeout: .distantFuture)
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

            return events
            
        } else {
            
            
            return [Event]()
        }

        
        
    }
    
    
    fileprivate func updateSearchResults(_ data: Data?)-> [Event]? {

        var eventResults = [Event]()
        
        var results = [Events]()
        
        var json: [String: AnyObject]!
        
        
        do {
            
            json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
            
        } catch {
            
            print(error)
            
        }
        if (json == nil) {
            
            
            return nil
        }
        
        guard let result = EventFeed(json: json) else {
            
            
            return nil
        }
        
        
        guard let events = EventResults(json: result.events as! JSON) else {
            
            
            return nil
        }
        
        
        if(events.items != nil) {
            
            for item in events.items! {

                results.append(item)

            }
            
        }
        
        for result in results {
            
            
            let eventResult =   parseResults(event: result)
            
            if(eventResult != nil) {

                eventResults.append(eventResult!)
                
            }
            
        }
        
        return eventResults
        
    }
    
    
    func parseResults(event: Events) -> Event? {
        
        var eventResult: Event?
        
        let description: String = event.description!
 
        let filtered = filterString(string: description)

        let separatedDescription = filtered.components(separatedBy: [" "])

        let startDateString = separatedDescription[1]
        
        let startDate = formatDate(date: startDateString)
        
        let endDateString = separatedDescription[3]
        
        let endDate = formatDate(date: endDateString)
        
        let location = getLocation(stringArray: separatedDescription)
        
        let liveStream = getLiveStreamAddress(stringArray: separatedDescription)
        
        let escapedString = event.image?.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let url = NSURL(string: escapedString! )

        if((event.title != nil) && event.image != nil && event.link != nil && location != nil && liveStream != nil ) {
            
            
            
            eventResult = Event(title: event.title!, startDate: startDate, endDate: endDate,  liveStream: liveStream!, image: url!)
            
        }
        

        return eventResult
        
    }
    
    func getLiveStreamAddress(stringArray: [String]) -> String? {
        
        let stringArray = stringArray
        
        var liveStreamAddress = ""

        for element in stringArray {
            

            if element.range(of:"http://wowza1") != nil {

                liveStreamAddress = element
                
                
                break
                
                
            }
            
  
            
        }
        
        if(liveStreamAddress != "") {
        
        liveStreamAddress =  liveStreamAddress.substring(from: liveStreamAddress.characters.index(liveStreamAddress.startIndex, offsetBy: 1))

        liveStreamAddress =   liveStreamAddress.substring(to: liveStreamAddress.index(before: liveStreamAddress.endIndex))
        
        } else {
            
            
            liveStreamAddress = String("http://wowza1.ctv15.org:1935/Live1/live/playlist.m3u8")
        }
 
        return liveStreamAddress
        
        
        
    }
    
    
    func getLocation(stringArray: [String]) -> String? {
        
        var location = ""
        
        let separatedString = stringArray

        let subString =   separatedString.dropFirst(5)
        
        
        for element in subString {
            
            
            if(element != "Description:") {
                
                
                
                location = location + " " +  element
                
                
            } else {
                
                
                break
                
            }
            
            
        }
        
        location = location.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        return location
    }
    
    
    func convertDateFormatter(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"//this your string date format
        
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        let date = dateFormatter.date(from: date)

        dateFormatter.dateFormat = "yyyy MMM-dd EEEE HH:mm"///this is you want to convert format
        
        dateFormatter.timeZone = NSTimeZone(name: "America/Chicago") as TimeZone!
        
        let timeStamp = dateFormatter.string(from: date!)

        return timeStamp
    }
    
    
    
    
    
    func formatDate(date: String) -> Date {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"//this your string date format
        
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        let date = dateFormatter.date(from: date)

      

        return date!
        
    }
    
    func filterString(string: String) -> String{
        
        var filteredString = string.replacingOccurrences(of: "<b>", with: "", options: NSString.CompareOptions.literal, range:nil)
        
        
        filteredString = filteredString.replacingOccurrences(of: "</b>", with: "", options: NSString.CompareOptions.literal, range:nil)
        
        filteredString = filteredString.replacingOccurrences(of: "</br>", with: " ", options: NSString.CompareOptions.literal, range:nil)
        
        filteredString = filteredString.replacingOccurrences(of: "<br|/>|<div>|<img|</div>|src=", with: "", options: .regularExpression, range:nil)
        
        return filteredString
    }
    
    
    
}



public struct EventFeed: Decodable {
    
    public let events: NSDictionary?
    
    public init?(json: JSON) {
        
        let events: NSDictionary? = "value" <~~ json
        
        self.events = events
        
    }
    
}


public struct EventResults: Decodable {
    
    public let items: [Events]?
    
    public init?(json: JSON) {
        
        items = "items" <~~ json
        
    }
    
}



public struct Events: Decodable {
    
    public let title: String?
    
    public let link: String?
    
    public let description: String?
    
    public let image: String?
    
    public init?(json: JSON) {
        
        title = "title" <~~ json
        
        link = "link" <~~ json
        
        description = "description" <~~ json
        
        image = "Event_Photo" <~~ json
        
    }
    
}


class Event {
    
    var startDate: Date
    
    var endDate: Date
    
    var title: String
    
    var image: NSURL
    
    var liveStream: String
    
    
    init(title: String, startDate: Date, endDate: Date,  liveStream: String, image: NSURL) {
        
        self.title = title
        
        self.startDate = startDate
        
        self.endDate = endDate
        
        self.liveStream = liveStream
        
        self.image = image
        
    }
    
}











