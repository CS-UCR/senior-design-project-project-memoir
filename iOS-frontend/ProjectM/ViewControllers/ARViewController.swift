//
//  ARViewController.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/1/21.
//

import UIKit
import RealityKit
import Combine
import ARKit
import MapKit
var added = false;


class ARViewController: UIViewController, ARSessionDelegate {
    // Array containing the latitude, longitude, and altitude of AR message created.
    // Append new data when user creates a new message
    var messageLocation = [ARRaycastResult]()
    
    @IBOutlet weak var ARView: ARView!

    // Hold messages users post
    var userMessages = [MessageEntity]()
    var editMessageBox: MessageEntity!
    // TESTING: geoAnchors_array WILL HOLD ANCHORS SO WE CAN SAVE THEM LATER.
    // CANNOT USE userMessages above since it is an entity and not an anchor
    var geoAnchors_array=[ARGeoAnchor]()
    // TESTING
    // Gets the anchors from the last frame captured by rear iPhone camera
    /*
    var currentAnchors: [ARAnchor] {
        return ARView.session.currentFrame?.anchors ?? []
    }
     */
    var savedGeoAnchors = [ARGeoAnchor]()
    var subscription: Cancellable!
    // Dim background so user can focus on message while typing
    var shadeView: UIView!
    // Get the keyboard height once user starts typing
    var keyboardHeight: CGFloat!
    // Button will remove all mes ewsages on the screen
    var clearButton: UIButton!
    
    let locationManager = CLLocationManager()
    let coachingOverlay = ARCoachingOverlayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if targetEnvironment(simulator)
        print("in simulator")
        #else
        ARView.automaticallyConfigureSession = false
        // setup different gestures to recognize user actions
        let ARSingleTapGesture = UITapGestureRecognizer(target: self, action: #selector(userTapsOnARView))
        
        // Attach gesture recognizer for user's tap in our ARView
        ARView.addGestureRecognizer(ARSingleTapGesture)
        
        // setup coaching overlay
        setupCoachingOverlay()
        
        // ARView.session.delegate periodically receives video images
        // captured with position tracking information
        // Link about video images captures:
        // https://developer.apple.com/documentation/arkit/arframe
        ARView.session.delegate = self

        // place subviews
        // - need message subviews for reading, writing, and editing
        placeEditBox()
        
        // run ar session
        runARSession()
        #endif
       
    }

    
    @IBAction func showEditBox(_ sender: Any) {
        // Get a 3D point (user's message) and convert it to 2D
        self.showEditBox()
    }
    
    func showEditBox() {
        guard let messageView = self.editMessageBox.view else { return }
        messageView.textView.becomeFirstResponder()
        focusOnMessageView(messageView)
    }

    func showEditBox(text: String) {
        guard let messageView = self.editMessageBox.view else { return }
        messageView.textView.becomeFirstResponder()
        messageView.textView.text = text
        focusOnMessageView(messageView)
    }

    func placeExistingMessages() {
        Network.shared.apollo.fetch(query: ListAnchorsQuery(limit: 20)) { result in
            switch result {
            case .success(let graphQLResult):
                guard let items = graphQLResult.data?.listAnchors?.items else { break }

                for optionalItem in items {
                    
                    guard let item = optionalItem else { continue }
                    guard let lat = item.lat else {continue}
                    guard let long = item.long else {continue}
                    let loc = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    let messageString = item.message ?? ""
                    self.addGeoLocationToAnchor(at: loc, message: messageString)
                }

            case .failure(_):
                print("LOG - placeExistingMessages error")
            }
        }
    }

    func placeEditBox() {
            guard let view = view else {
            fatalError("LOG ERROR - Called getCenterPoint(_point:) on a screen space component with no view.")
        }
        
        let frame = CGRect(origin: CGPoint(x:view.frame.width/2 - 150, y:view.frame.height + 200), size: CGSize(width: 300, height: 200))

        let message = MessageEntity(frame: frame)
        guard let messageView = message.view as? MessageView else { return }
        messageView.textView.delegate = self

        self.ARView.addSubview(messageView)
        self.editMessageBox = message
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add observer to the keyboardWillShowNotification to get the height of the keyboard every time it is shown
        let notificationName = UIResponder.keyboardWillShowNotification
        let selector = #selector(keyboardIsPoppingUp(notification:))
        NotificationCenter.default.addObserver(self, selector: selector, name: notificationName, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    

    // Presents the available actions when the user presses the Save/Load button.
    func presentMenuOptions() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Load Anchors ???", style: .default, handler: { (_) in
            self.loadAnchors()
        }))
        actionSheet.addAction(UIAlertAction(title: "Save Anchors ???", style: .default, handler: { (_) in
            self.saveAnchors()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
    
    
    // Save anchors to server
    // This is meant to replicate server
    func saveAnchors(){
        if !geoAnchors_array.isEmpty {
            savedGeoAnchors = geoAnchors_array
        }
    }
    
    // Load anchors from "server"
    func loadAnchors(){
        geoAnchors_array = savedGeoAnchors
        for geoAnchor in geoAnchors_array {
            prepareToAddGeoAnchor(geoAnchor, "text")
        }
    }
    
    func runARSession() {
        ARGeoTrackingConfiguration.checkAvailability { (available, error) in
            guard available else {
                print("LOG ERROR - Geolocation availability does not work. See: https://developer.apple.com/documentation/arkit/argeotrackingconfiguration/3571351-checkavailability")
                self.runARSession()
                return
            }

            let geoTrackingConfig = ARGeoTrackingConfiguration()
            geoTrackingConfig.planeDetection = [.horizontal]
            //self.ARView.debugOptions = [.showPhysics]
            self.ARView.session.run(geoTrackingConfig)

        }
    }
    
    // clear all of the messages in our AR world
    // Ex: if 5 messages exist, clear() will remove all from our AR world
    func clear() {
        // get configuration for our AR view
        guard let configuration = ARView.session.configuration else { return }
        // remove anchors from our arView
        ARView.session.run(configuration, options: .removeExistingAnchors)
        // for loop removes message from our list of messages
        for message in userMessages {
            deleteMessage(message)
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else {
            print("session error: \(error)")
            return
        }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        
        DispatchQueue.main.async {
            // Present an alert informing about the error that has occurred.
            let alertController = UIAlertController(title: "The AR session failed.", message: errorMessage, preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
                alertController.dismiss(animated: true, completion: nil)
                self.clear()
            }
            alertController.addAction(restartAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func distanceFromDevice(_ coordinate: CLLocationCoordinate2D) -> Double {
        if let devicePosition = locationManager.location?.coordinate {
            return MKMapPoint(coordinate).distance(to: MKMapPoint(devicePosition))
        } else {
            return 0
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}
