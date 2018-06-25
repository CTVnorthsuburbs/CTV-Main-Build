//
//  AboutViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 12/13/16.
//  
//

import UIKit
import MapKit
import AddressBook

class AboutViewController: UIViewController
{
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
   
    
    // set initial location in Honolulu
    let initialLocation = CLLocation(latitude: 45.0218381, longitude: -93.1795165)
    
   
    
    let regionRadius: CLLocationDistance = 1000
    
    
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        
        
        textView.isEditable = false
         textView.dataDetectorTypes = [UIDataDetectorTypes.address, UIDataDetectorTypes.phoneNumber]
  
        
        
        
        textView.text = "Contact Info & Hours\n\n2670 Arthur Street, MN 55113\nPhone: 651-792-7515,\nWeb: www.ctvnorthsuburbs.org\nMonday through Thursday: 9:00 am to 9:00 pm\nFriday: 9:00 am to 6:30 pm, Saturday: 9:00 am to 4:30 pm on the first Saturday of the month, Sunday:Closed\n\nAbout CTV\n\nCTV North Suburbs is your local community media center serving nine cities: Arden Hills, Falcon Heights, Lauderdale, Little Canada, Mounds View, New Brighton, North Oaks, Roseville and St. Anthony.\n\nCTV is a non-profit organization operated by the North Suburban Access Corporation, a board of directors representing each of the nine member cities. They have come together to offer you a community media center with programming created by the community, for the community.\n"
        
        
        
      
        super.viewDidLoad()
        
centerMapOnLocation(location: initialLocation)
        
        // show artwork on map
        let artwork = Artwork(title: "CTV North Suburbs",
                              locationName: "2670 Arthur St Roseville, MN 55113",
                             
                              coordinate: CLLocationCoordinate2D(latitude: 45.0218381, longitude: -93.1795165))
        mapView.delegate = self
        mapView.addAnnotation(artwork)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
  
    
    

}

extension AboutViewController: MKMapViewDelegate {
    
    
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                    view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }

    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    
}


class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
 
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    
    

    
    
 
}
