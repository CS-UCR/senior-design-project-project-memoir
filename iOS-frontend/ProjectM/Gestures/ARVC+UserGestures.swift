//
//  VC+UserGestures.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/2/21.
//

import UIKit
import ARKit
import RealityKit

extension ARViewController {
    // Setup the gestures for our AR world
    func arViewUserGestures(){
        // If tapGesture is recognized from user, go to userTapsOnARView() below.
        let userTapGesture = UITapGestureRecognizer(target: self, action: #selector(userTapsOnARView))
        // Attach gesture recognizer for user's tap in our ARView
        ARView.addGestureRecognizer(userTapGesture)

    }
    
    // Set up gestures for user to use on messages
    // Ex: drag message or tap on message to edit
    func messageGestureSetup(_ note: MessageEntity) {
        // panMovement: records the movement of message from start to finish
        let panMovement = UIPanGestureRecognizer(target: self, action: #selector(panOnMessageView))
        note.view?.addGestureRecognizer(panMovement)
        // If user taps on message, call userTapsOnMessageView
        let tapMessageView = UITapGestureRecognizer(target: self, action: #selector(userTapsOnMessagView(_:)))
        note.view?.addGestureRecognizer(tapMessageView)
    }
    
    // panUserMessage allows the user to drag a message in our AR world
    // Ex: if the user placed the message at the wrong location (too high or too low)
    fileprivate func panUserMessage(_ sender: UIPanGestureRecognizer, _ messageView: MessageView, _ panLocation: CGPoint) {
        errorMessageLabel.isHidden = true
        // feedbackGenerator allows us to use the taptic engine to improve feedback
        // Ex: Remove any lag when the user is draggin a message
        let feedbackGenerator = UIImpactFeedbackGenerator()
        
        // Use switch statement to get the state of our message
        switch sender.state {
            // Message is being dragged
            case .began:
                // Start taptic engine to remove any lag
                // We need to start it prior to draggin our message since starting our taptic engine
                // too late can cause delays.
                feedbackGenerator.prepare()
                
                // Dragging is true if user is still dragging message
                messageView.userMessage.isDragging = true
                
                // Save offsets to create a smooth transition/movement.
                // frame: get the coordinates of our ARView screen
                guard let frame = sender.view?.frame else { return }
                messageView.xOff = panLocation.x - frame.origin.x
                messageView.yOff = panLocation.y - frame.origin.y
                
            // Message is not being dragged
            case .ended:
                // Set to false if user stopped dragging message
                messageView.userMessage.isDragging = false
                // Place the message at the new location user dragged it to.
                repositionARMessage(messageView)
            
            default:
                // Update the location of message on the screen based on how the user moved their iphone
                // We use the (location of where the user is looking) - (the location of message prior to moving)
                messageView.frame.origin.x = panLocation.x - messageView.xOff
                messageView.frame.origin.y = panLocation.y - messageView.yOff
                
               
        }
    }
    
    
    // @objc let's our program use objective C and Swift code at the same time.
    // If we don't add @objc our code crashes
    // @objc is used to create dynamic calls for certain methods
    // How we use it is, anytime #selector is called we pass it a method.
    // (Ex: #selector for userTapGesture inside arViewGesture() above)
    @objc
    // userTapsOnARView will add a new message to our screen if necessary
    func userTapsOnARView(_ sender: UITapGestureRecognizer){
        // Ignore the tap if the user is editing a message and return.
        for message in userMessages where message.isEditing { return }
        // The users tap on the iPhone will give us an (x,y) coordinates on the iPhone screen.
        let user_click = sender.location(in: ARView)
        
        // Perform ARKit raycast on tap location
        if let result = ARView.raycast(from: user_click, allowing: .estimatedPlane, alignment: .any).first {
            getGeoLocation(worldPosition: result)
        } else {
            errorMessageLabel.displayErrorMessage("No raycast result.\nTry pointing at a different area\nor move closer to the surface.")
        }

    }


    @objc
    // userTapsOnMessageView will get the messageView the user tapped on
    // Ex: if there are 5 messages on the screen, get the one the user tapped on
    func userTapsOnMessagView(_ sender: UITapGestureRecognizer) {
        guard let messageView = sender.view as? MessageView else { return }
        messageView.textView.becomeFirstResponder()
    }
    
    
    @objc
    // panOnMessageView allows user to drag message
    func panOnMessageView(_ sender: UIPanGestureRecognizer) {
        // hide error message label while user is dragging message
        errorMessageLabel.isHidden = true
        
        guard let messageView = sender.view as? MessageView else { return }
        // get pan location from our AR world
        let panLocation = sender.location(in: ARView)
        
        // Ignore the pan if any user messages are being edited.
        for note in userMessages where note.isEditing { return }
        
        panUserMessage(sender, messageView, panLocation)
    }
    
    
    // Reposition our AR message
    fileprivate func repositionARMessage(_ messagView: MessageView) {
        // Get the x,y point of our message
        let point = CGPoint(x: messagView.frame.midX, y: messagView.frame.midY)
        // Make sure our message was repositioned at an acceptable location by using raycast
        if let raycastResult = ARView.raycast(from: point, allowing: .estimatedPlane, alignment: .any).first {
            messagView.userMessage.transform.matrix = raycastResult.worldTransform
        // else display error message
        } else {
            errorMessageLabel.displayErrorMessage("No surface detected, unable to reposition note.", duration: 2.0)
            messagView.userMessage.shouldAnimate = true
        }
    }
    
    // STARTS HERE
    // getGeoLocation gets us the location and altitude based on where the user clicks on their iphone screen
    func getGeoLocation(worldPosition: ARRaycastResult){
        // Parse the information from our raycastResult, else we encountered an error.
        // We will use these coordinates to place our AR message
        // Closure Expression Syntax
        // @see https://docs.swift.org/swift-book/LanguageGuide/Closures.html#ID97
        // Based on the user click, we will get a location and altitude. Location gives us a longitude and latitude.
        ARView.session.getGeoLocation(forPoint: worldPosition.worldTransform.translation) { (location, altitude, error) in
            if let error = error {
                return
            }
            // If we get the location then call addGeoAnchor below with our coordinates.
            self.addGeoLocationToAnchor(at: location, altitude: altitude)
        }
        
    }
    
    
    // addGeoLocation creates an ARGeoAnchor to assign it a location
    func addGeoLocationToAnchor(at location: CLLocationCoordinate2D, altitude: CLLocationDistance? = nil){
        // Create a geoAnchor variable to assign it our location
        var geoAnchor: ARGeoAnchor!
        // Assign geoLocation
        geoAnchor = ARGeoAnchor(coordinate: location)
        prepareToAddGeoAnchor(geoAnchor)
    }
    
    // ENDS HERE
    // prepareToAddGeoAnchor adds the geoAnchor to our AR world
    func prepareToAddGeoAnchor(_ geoAnchor: ARGeoAnchor){
        ARView.session.add(anchor: geoAnchor)
    }

    
    func deleteMessage(_ note: MessageEntity) {
        guard let index = userMessages.firstIndex(of: note) else { return }
        note.removeFromParent()
        userMessages.remove(at: index)
        note.view?.removeFromSuperview()
    }
    
    @objc
    func userTappedClear(_ sender: UIButton) {
        clear()
    }
    
    @objc
    func userTappedMenu(_ sender: UIButton){
        presentMenuOptions()
    }
}

