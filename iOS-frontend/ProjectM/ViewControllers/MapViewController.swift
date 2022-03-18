//
//  MapViewController.swift
//  ProjectM
//
//  Created by Carlos Loeza on 3/18/22.
//

import ARKit
import MapKit
import UIKit

class MapViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var currentCoordinates: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
    
    private func zoomToCurrentLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500,longitudinalMeters: 500)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    
    private func beginLocationUpdates(locationManager: CLLocationManager){
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // get longtitude and latitude of current location
        locationManager.startUpdatingLocation()
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
