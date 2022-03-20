//
//  MapViewController.swift
//  ProjectM
//
//  Created by Carlos Loeza on 3/18/22.
//

import ARKit
import MapKit
import UIKit


// MyPointAnnotation allows us to give our MKPointAnnotation
// different colors.
// Add custom property, pinTintColor, in order to use .coordinate in MKPointAnnotation
class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}


class MapViewController: UIViewController, MKMapViewDelegate{
    
    private let locationManager = CLLocationManager()
    private var currentCoordinates: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Golden Gate Park pins
        var annotationLocations = [
            ["latitude": 37.770412, "longitude": -122.480161 ],
            ["latitude": 37.771771, "longitude": -122.469390],
            ["latitude": 37.769294, "longitude": -122.467352],
            ["latitude": 37.770182, "longitude": -122.470194],
            ["latitude": 37.771713, "longitude": -122.460053],
            ["latitude": 37.771208, "longitude": -122.466793],
            ["latitude": 37.766884, "longitude": -122.492708],
            ["latitude": 37.769571, "longitude": -122.498083],
            ["latitude": 37.769609, "longitude": -122.497076],
            ["latitude": 37.765822, "longitude": -122.495574],
            ["latitude": 37.770132, "longitude": -122.466662],
            ["latitude": 37.772104, "longitude": -122.460050],
            ["latitude": 37.771751, "longitude": -122.471294],
            ["latitude": 37.769718, "longitude": -122.472314],
            // stow lake
            ["latitude": 37.769718, "longitude": -122.472314],
            ["latitude": 37.769584, "longitude": -122.473504],
            ["latitude": 37.769753, "longitude": -122.474738],
            ["latitude": 37.770608, "longitude": -122.476832],
            ["latitude": 37.769274, "longitude": -122.474668],
            ["latitude": 37.767836, "longitude": -122.476524],
            // botanical gardens
            ["latitude": 37.769132, "longitude": -122.470423],
            ["latitude": 37.769110, "longitude": -122.470185],
            // de young museum
            ["latitude": 37.771056, "longitude": -122.468537],
            ["latitude": 37.771336, "longitude": -122.468140],
            // music concourse
            ["latitude": 37.770522, "longitude": -122.467512],
            ["latitude": 37.770308, "longitude": -122.467096],
        ]
        

        
        configureLocationServices()
        placeAnchorsOnMap(locations: annotationLocations)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // configureLocationServices checks to see if we have permission
    // to use get user's location
    private func configureLocationServices() {
        locationManager.delegate = self
        // location status
        let status = CLLocationManager.authorizationStatus()
        // check if we have user's location
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    // beginLocationUpdates
    private func beginLocationUpdates(locationManager: CLLocationManager){
        mapView.showsUserLocation = true
        // kCLLocationAccuracyBest = high accuracy for user location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // get longtitude and latitude of current location
        locationManager.startUpdatingLocation()
    }
    
    // counter used for testing color in pin
    var counter = 0
    
    // placeAnchorsOnMap allows us to place a pin on our map.
    // Currently places red pins but I also want to add other colors
    func placeAnchorsOnMap(locations: [[String : Double]]){
        // get all the locations
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            // brute force to assign a title to each annotation.
            // title determines the color of annotation. (see func mapView() below for reference)
            if (counter % 3 == 0){
                annotation.title = "Public"
            } else {
                annotation.title = "Friends"
            }
            // Add pin to map
            mapView.addAnnotation(annotation)
            //
            counter+=1
        }
        print(counter-1)
    }
    
    // Create pin and assign it a color
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // if annotation location == user's location, do not assign it a colored pin.
        // We want to keept the user's location appearance as a blue dot.
        // Ex: blue dot on Apple Maps showing your location
        guard !(annotation is MKUserLocation) else { return nil }
        // create the balloon pin which shows the location of messages posted
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
        // Pin colors:
        // 1. Twitter blue
        let twitterBlue = UIColor(red: 0/255.0, green: 172/255.0, blue: 238/255.0, alpha: 1.0)
        // 2. Memoir green
        let memoirGreen = UIColor(red: 130/255.0, green: 255/255.0, blue: 175/255.0, alpha: 1.0)
        // Check if message is for public view or only friends, and determine what color to assing it.
        // Blue is public and green is friends only
        switch annotation.title!! {
            case "Public":
                // Color: Memoir green
                annotationView.markerTintColor = memoirGreen
                annotationView.glyphImage = UIImage(systemName: "person.3.fill")
            case "Friends":
                // Color: Twitter blue
                annotationView.markerTintColor = twitterBlue
                annotationView.glyphImage = UIImage(systemName: "star.fill")
            default:
                annotationView.markerTintColor = twitterBlue
        }
        return annotationView
    }
    
    // zoomToCurrentLocation tells our map how zoomed
    // Example: seeing an entire city vs only your neighborhood
    private func zoomToCurrentLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500,longitudinalMeters: 500)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {return}
        
        if currentCoordinates == nil {
            zoomToCurrentLocation(with: latestLocation.coordinate)
        }
        currentCoordinates = latestLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}
