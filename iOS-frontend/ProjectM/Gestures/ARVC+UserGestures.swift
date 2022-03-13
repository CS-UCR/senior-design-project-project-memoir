//
//  VC+UserGestures.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/2/21.
//

import UIKit
import ARKit
import RealityKit

struct Message {
    var text: String
}

extension ARViewController {
    // Set up gestures for user to use on messages
    // Ex: drag message or tap on message to edit
    func messageGestureSetup(_ note: MessageEntity) {
        // panMovement: records the movement of message from start to finish
        let panMovement = UIPanGestureRecognizer(target: self, action: #selector(panOnMessageView))
        note.view?.addGestureRecognizer(panMovement)
        // If user taps on message, call userTapsOnMessageView
        let tapMessageView = UITapGestureRecognizer(target: self, action: #selector(userTapsOnMessagView(_:)))
        note.view?.addGestureRecognizer(tapMessageView)
        note.view?.deleteButton.messageEntity = note
        note.view?.deleteButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc
    func buttonAction(sender: DeleteUIButton!) {
        do {
            deleteMessage(sender.messageEntity!)
        } catch {
            print(error)
        }
        //print(sender?.messageEntity)
    }
    // panUserMessage allows the user to drag a message in our AR world
    // Ex: if the user placed the message at the wrong location (too high or too low)
    fileprivate func panUserMessage(_ sender: UIPanGestureRecognizer, _ messageView: MessageView, _ panLocation: CGPoint) {
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
        
        // The users tap on the iPhone will give us an (x,y) coordinates on the iPhone screen.
        let point = sender.location(in: view)
        
        guard let entity = ARView.entity(at: point)
        else {
//            CustomElements.clickIndicator(loc: point, startRadius: 20.0, endRadius: 40.0, controller: self, color: UIColor.white)
//
            // NOTE - more efficient to reuse same toast layer but how fast can the user click anyway :P
            ARView.layer.sublayers?.filter{ $0.name == "toast - entity not found" }
                .forEach{ $0.removeFromSuperlayer() }

            // let user know there was no entity found at location
            CustomElements.toast(message: "sorry, no messages here!", controller: self)
            return
        }
//        CustomElements.clickIndicator(loc: point, startRadius: 20.0, endRadius: 40.0, controller: self, color: UIColor.green)
        var message = entity.name;
        if(message != "pin" && !message.contains("simpB")) {
            CustomElements.message(message: message, controller: self)
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
            messagView.userMessage.shouldAnimate = true
        }
    }
    
    // addGeoLocation creates an ARGeoAnchor to assign it a location
    func addGeoLocationToAnchor(at location: CLLocationCoordinate2D, altitude: CLLocationDistance? = nil, message: String){
        // Create a geoAnchor variable to assign it our location
        var geoAnchor: ARGeoAnchor!
        // Assign geoLocation
        geoAnchor = ARGeoAnchor(coordinate: location)
        prepareToAddGeoAnchor(geoAnchor, message)
    }
    
    // ENDS HERE
    // prepareToAddGeoAnchor adds the geoAnchor to our AR world
    func prepareToAddGeoAnchor(_ geoAnchor: ARGeoAnchor, _ message: String){
        // Don't add a geo anchor if Core Location isn't sure yet where the user is.
        guard isGeoTrackingLocalized else {
            debugPrint("LOG - ERROR. Cannot add geo anchor to session because arcore location has not identified where the user is.")
            return
        }
        
        ARView.session.add(anchor: geoAnchor)
        
        // create geoAnchorEntity for our message
        let geoAnchorEntity = AnchorEntity(anchor: geoAnchor)
        let entity = try! Entity.load(named: "pin")
        entity.name = message
        //entity.name = "geo anchor entity message"
        // double scale size
        entity.scale = [3, 3, 3]
        
        // create parent entity
        let parentEntity = ModelEntity()
        parentEntity.name = message
        parentEntity.addChild(entity)
        
        //parentEntity.name = "geo anchor pin collision box"
        
        // create bounds for parent entity
        let entityBounds = entity.visualBounds(relativeTo: parentEntity)
        parentEntity.collision = CollisionComponent(shapes: [ShapeResource.generateBox(size: entityBounds.extents).offsetBy(translation: entityBounds.center)])
        parentEntity.generateCollisionShapes(recursive: false)
        
        // install gestures and add child
        // ARView.installGestures([.all], for: parentEntity)
        geoAnchorEntity.addChild(parentEntity)
        ARView.scene.addAnchor(geoAnchorEntity)
    }
    
    var isGeoTrackingLocalized: Bool {
        if let status = self.ARView.session.currentFrame?.geoTrackingStatus, status.state == .localized {
            return true
        }
        return false
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

