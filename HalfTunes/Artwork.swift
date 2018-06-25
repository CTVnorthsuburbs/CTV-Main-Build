//
//  Artwork.swift
//  CTV App
//
//  Created by Charlie Rooney on June 20th 2018
//
//This  class is for the Red Pin on The Map Page in the About Page
//Code used from https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation
{
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }//init
    
    var subtitle: String? {return locationName}
    
    func mapItem() -> MKMapItem
    {
       let addressDict = [CNPostalAddressStreetKey: subtitle!]
       let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
       let mapItem = MKMapItem(placemark: placemark)
        
       mapItem.name = title
       return mapItem
    }
 
}//Artwork

