//
//  AboutViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 12/13/16.
//  
// Updated by Charlie Rooney on June 20th 2018

import UIKit
import MapKit
import AddressBook

class AboutViewController: UIViewController
{
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    // set initial location to CTV
    let initialLocation = CLLocation(latitude: 45.0219891, longitude: -93.17971269999998) //Coordinates of CTV North Suburbs
    let regionRadius: CLLocationDistance = 2000 //a distance measured in meters around an existing location
    
    func centerMapOnLocation(location: CLLocation)
    {
       let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius , regionRadius)
       mapView.setRegion(coordinateRegion, animated: true)
    }//centerMapOnLocation
    
    override func viewDidLoad()
    {
        // Map
        centerMapOnLocation(location: initialLocation)//calls the center map function
        mapView.delegate = self
        let artwork = Artwork(title: "CTV North Suburbs", locationName: "2670 Arthur St Roseville, MN 55113", discipline: "CTV", coordinate: CLLocationCoordinate2D(latitude: 45.0219891, longitude: -93.17971269999998))
        mapView.addAnnotation(artwork)
        

        // Text
        textView.isEditable = false
        textView.dataDetectorTypes = [UIDataDetectorTypes.address, UIDataDetectorTypes.phoneNumber, UIDataDetectorTypes.link]
        textView.text = "Contact Info & Hours\n\n2670 Arthur Street, MN 55113\nPhone: 651-792-7515,\nWeb: www.ctvnorthsuburbs.org\nMonday through Thursday: 9:00 am to 9:00 pm\nFriday: 9:00 am to 6:30 pm, Saturday: 9:00 am to 4:30 pm on the first Saturday of the month, Sunday:Closed\n\nAbout CTV\n\nCTV North Suburbs is your local community media center serving nine cities: Arden Hills, Falcon Heights, Lauderdale, Little Canada, Mounds View, New Brighton, North Oaks, Roseville and St. Anthony.\n\nCTV is a non-profit organization operated by the North Suburban Access Corporation, a board of directors representing each of the nine member cities. They have come together to offer you a community media center with programming created by the community, for the community.\n"
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }//viewDidLoad

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//didReceiveMemoryWarning
}//AboutViewController

extension AboutViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKPinAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    //opens pin in maps
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
}

