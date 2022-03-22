//
//  MapViewController.swift
//  ProjectM
//
//  Created by Carlos Loeza on 3/18/22.
//

import ARKit
import MapKit
import UIKit

// Helps us truncate location latitude so we know where pins are location.
// We will use this to distinguish SF State pins
extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
// mock data to test how pins will appear on map
var annotationLocations = [
    // Golden Gate Park pins
    ["latitude": 37.770412, "longitude": -122.480161], ["latitude": 37.771771, "longitude": -122.469390],
    ["latitude": 37.769294, "longitude": -122.467352], ["latitude": 37.770182, "longitude": -122.470194],
    ["latitude": 37.771713, "longitude": -122.460053], ["latitude": 37.771208, "longitude": -122.466793],
    ["latitude": 37.766884, "longitude": -122.492708], ["latitude": 37.769571, "longitude": -122.498083],
    ["latitude": 37.769609, "longitude": -122.497076], ["latitude": 37.765822, "longitude": -122.495574],
    ["latitude": 37.770132, "longitude": -122.466662], ["latitude": 37.772104, "longitude": -122.460050],
    ["latitude": 37.771751, "longitude": -122.471294], ["latitude": 37.769718, "longitude": -122.472314],
    // stow lake
    ["latitude": 37.769718, "longitude": -122.472314], ["latitude": 37.769584, "longitude": -122.473504],
    ["latitude": 37.769753, "longitude": -122.474738], ["latitude": 37.770608, "longitude": -122.476832],
    ["latitude": 37.769274, "longitude": -122.474668], ["latitude": 37.767836, "longitude": -122.476524],
    // botanical gardens
    ["latitude": 37.769132, "longitude": -122.470423], ["latitude": 37.769110, "longitude": -122.470185],
    // de young museum
    ["latitude": 37.771056, "longitude": -122.468537], ["latitude": 37.771336, "longitude": -122.468140],
    // music concourse
    ["latitude": 37.770522, "longitude": -122.467512], ["latitude": 37.770308, "longitude": -122.467096],
    // -----------------------------------------------
    // SF State pins
    // Train stop
    ["latitude": 37.721216, "longitude": -122.475226], ["latitude": 37.721292, "longitude": -122.475217],
    ["latitude": 37.721500, "longitude": -122.475216], ["latitude": 37.721714, "longitude": -122.475212],
    ["latitude": 37.721407, "longitude": -122.475215], ["latitude": 37.721166, "longitude": -122.475229],
    // Holloway St. pins
    ["latitude": 37.720895, "longitude": -122.476290], ["latitude": 37.720937, "longitude": -122.477671],
    ["latitude": 37.720897, "longitude": -122.476754], ["latitude": 37.720984, "longitude": -122.478978],
    ["latitude": 37.720972, "longitude": -122.478549], ["latitude": 37.720961, "longitude": -122.478137],
    // Library
    ["latitude": 37.721047, "longitude": -122.478211], ["latitude": 37.721573, "longitude": -122.477566],
    ["latitude": 37.721675, "longitude": -122.478636], ["latitude": 37.720990, "longitude": -122.477986],
    ["latitude": 37.721525, "longitude": -122.478704], ["latitude": 37.721414, "longitude": -122.478776],
    // Pub
    ["latitude": 37.721890, "longitude": -122.478062], ["latitude": 37.722138, "longitude": -122.478429],
    ["latitude": 37.722213, "longitude": -122.478424], ["latitude": 37.721943, "longitude": -122.478921],
    // Walk to library from train
    ["latitude": 37.721278, "longitude": -122.475699], ["latitude": 37.721307, "longitude": -122.475848],
    ["latitude": 37.721366, "longitude": -122.476265], ["latitude": 37.721419, "longitude": -122.476467],
    ["latitude": 37.721321, "longitude": -122.475870], ["latitude": 37.721412, "longitude": -122.477238],
]


class MapViewController: UIViewController, MKMapViewDelegate{
    
    private let locationManager = CLLocationManager()
    private var currentCoordinates: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureLocationServices()
        placeAnchorsOnMap()
        //placeMockAnchorsOnMap(locations: annotationLocations)
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
    
    
    // placeAnchorsOnMap allows us to place a pins from our server to map.
    func placeAnchorsOnMap(){
        // Call server to get location from messages
        Network.shared.apollo.fetch(query: ListAnchorsQuery(limit: 20)) { result in
            switch result {
            case .success(let graphQLResult):
                guard let locations = graphQLResult.data?.listAnchors?.items else { break }
                for location in locations {
                    // create annotation of type MKPointAnnotation to create pin for map
                    let annotation = MKPointAnnotation()
                    // get coordinates of message
                    guard let lat = location?.lat else {continue}
                    guard let long = location?.long else {continue}
                    let loc = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    // assign location to annotation.coord
                    annotation.coordinate = loc
                    // add title to annotation pin
                    annotation.title = "Friends"
                    // add annotation pin to our map
                    self.mapView.addAnnotation(annotation)
                }
            case .failure(_):
                print("LOG - placeExistingMessages error")
            }
        }
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
        // 3. SF State purple
        let sfStatePurple = UIColor(red: 70/255.0, green: 48/255.0, blue: 119/255.0, alpha: 1.0)
        // 4. SF State yellow
        let sfStateYellow = UIColor(red: 201/255.0, green: 151/255.0, blue: 0/255.0, alpha: 1.0)
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
            case "Students":
                // Color: SF State purple
                annotationView.markerTintColor = sfStatePurple
                annotationView.glyphImage = UIImage(systemName: "laptopcomputer")
            case "Student&Friend":
                // Color: SF State yellow
                annotationView.markerTintColor = sfStateYellow
                annotationView.glyphImage = UIImage(systemName: "star.fill")
            default:
                annotationView.markerTintColor = twitterBlue
        }
        return annotationView
    }
    
    
    // zoomToCurrentLocation tells our map how zoomed in to be when user opens map
    // Example: seeing an entire city vs only your neighborhood
    private func zoomToCurrentLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500,longitudinalMeters: 500)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    
    //----------------------------- Code for mock data ---------------------------------
    func placeMockAnchorsOnMap(locations: [[String : Double]]){
        // counter used for testing pin color
        var counter = 0
        
        // get all the locations from mock data
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            let truncated_latitude = annotation.coordinate.latitude.truncate(places: 2)
            if (truncated_latitude != 37.72){
                // brute force to assign a title to each annotation.
                // title determines the color of annotation. (see func mapView() for reference)
                if (counter % 3 == 0){
                    annotation.title = "Public"
                } else {
                    annotation.title = "Friends"
                }
            } else {
                if (counter % 4 == 0){
                    annotation.title = "Student&Friend"
                } else {
                    annotation.title = "Students"
                }
            }
            // Add pin to map
            mapView.addAnnotation(annotation)
            //
            counter+=1
        }
        print(counter-1)
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
