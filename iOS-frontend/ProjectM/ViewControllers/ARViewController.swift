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
    var currentAnchors: [ARAnchor] {
        return ARView.session.currentFrame?.anchors ?? []
    }
    var savedGeoAnchors = [ARGeoAnchor]()
    var subscription: Cancellable!
    // Dim background so user can focus on message while typing
    var shadeView: UIView!
    // Get the keyboard height once user starts typing
    var keyboardHeight: CGFloat!
    // Button will remove all mes ewsages on the screen
    var clearButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    @IBAction func showEditBox(_ sender: Any) {
        // Get a 3D point (user's message) and convert it to 2D
        self.showEditBox()
    }

    func showEditBox() {
        guard let messageView = self.editMessageBox.view else { return }
        messageView.textView.becomeFirstResponder()
        focusOnMessageView(messageView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ARView.automaticallyConfigureSession = false
        ARView.session.delegate = self
        // setup gestures to recognize user actions
        arViewUserGestures()
        // setup
        overlayUISetup()
        // ARView.session.delegate periodically receives video images
        // captured with position tracking information
        // Link about video images captures:
        // https://developer.apple.com/documentation/arkit/arframe
        ARView.session.delegate = self

        placeEditBox()
        // run ar session
        runARSession()
    }

    // Create an edit box entity and hide it off the screen
    func placeEditBox() {
        guard let view = view else {
            fatalError("Called getCenterPoint(_point:) on a screen space component with no view.")
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
        actionSheet.addAction(UIAlertAction(title: "Load Anchors …", style: .default, handler: { (_) in
            self.loadAnchors()
        }))
        actionSheet.addAction(UIAlertAction(title: "Save Anchors …", style: .default, handler: { (_) in
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
            prepareToAddGeoAnchor(geoAnchor)
        }
        
    }
    
    func runARSession() {
        ARGeoTrackingConfiguration.checkAvailability { (available, error) in
            guard available else {
                print("geo location does not works :( !")
                self.runARSession()
                return
            }
            
            print("geo location does works :) !")

            let geoTrackingConfig = ARGeoTrackingConfiguration()
            self.ARView.session.run(geoTrackingConfig)

            // Test placing anchors
            // let cords1 = CLLocationCoordinate2D(latitude: 33.977197859645955, longitude: -117.34819358120566)
            // let cords2 = CLLocationCoordinate2D(latitude: 33.97717306726972, longitude: -117.34821592500165)
            // self.addGeoLocationToAnchor(at: cords)
            // self.addGeoLocationToAnchor(at: cords1)
            // self.addGeoLocationToAnchor(at: cords2)
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

    
    // MARK: - ARSessionDelegate
    // THIS FUNCTION HELPS US ADD THE AR ANCHOR TO OUR AR WORLD AND MAP VIEW FOUND
    // ON THE BOTTOM HALF
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // CYCLE THROUGH ALL OF OUR GEOANCHORS
        print("added anchor in session")
        for geoAnchor in anchors.compactMap({ $0 as? ARGeoAnchor }) {
            // create geoAnchorEntity for our message
            
            let geoAnchorEntity = AnchorEntity(anchor: geoAnchor)
            let entity = try? Entity.load(named: "pin")
            geoAnchorEntity.addChild(entity!)
            self.ARView.scene.addAnchor(geoAnchorEntity)
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

