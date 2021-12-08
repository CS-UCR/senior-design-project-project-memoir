//
//  ARScreenSpace.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/1/21.
//


import RealityKit
import UIKit

// We want to build the functionality of our 2D message(Ex: user message) in a 3D space(AR)
// Protocol builds a skeleton of methods, properties, and other requirements for our tasks.
protocol HasARScreenSpace: Entity {
    var arScreenSpace: ARScreenSpace { get set }
}

// Next we create an extension to add the functions for our protocol arScreenSpace
extension HasARScreenSpace {
    // MessageView
    var view: MessageView? {
        get { arScreenSpace.view }
        set { arScreenSpace.view = newValue }
    }
    // if true, user can drag our 2D object (message in our case)
    // Ex: placing a message in a new location by dragging
    var isDragging: Bool {
        get { arScreenSpace.userDragging }
        set { arScreenSpace.userDragging = newValue }
    }
    // if true, user can edit a message
    // Ex: user can type/delete text from message
    var isEditing: Bool {
        get { arScreenSpace.userEditing }
        set { arScreenSpace.userEditing = newValue }
    }
    // if true, animate the position by moving it from original location to new location
    // Ex: if user moves their phone while using AR, reposition user's messages to new location
    var shouldAnimate: Bool {
        get { arScreenSpace.shouldAnimateMessage }
        set { arScreenSpace.shouldAnimateMessage = newValue }
    }
    
    
    // if true, get users projected point
    var projection: Projection? {
        get { arScreenSpace.projection }
        set { arScreenSpace.projection = newValue }
    }
    
    
    // Get and return the center point of the message entity's screen space view,
    // else throw error
    func getCenterPoint(_ point: CGPoint) -> CGPoint {
        guard let view = view else {
            fatalError("Called getCenterPoint(_point:) on a screen space component with no view.")
        }
        let xCoord = CGFloat(point.x) - (view.frame.width) / 2
        let yCoord = CGFloat(point.y) - (view.frame.height) / 2
        return CGPoint(x: xCoord, y: yCoord)
    }
    
    
    // Position the message entity's in the center based on location and ar space.
    func setPositionCenter(_ position: CGPoint) {
        let centerPoint = getCenterPoint(position)
        guard let view = view else {
            fatalError("Called centerOnHitLocation(_hitLocation:) on a screen space component with no view.")
        }
        view.frame.origin = CGPoint(x: centerPoint.x, y: centerPoint.y)
        
        // Update the frame once we finished editing the positing
        view.lastFrame = view.frame
    }
    

    // Animates the entity's screen space view to the the specified screen location, and updates the shouldAnimate
    // state of the entity.
    func animateTo(_ point: CGPoint) {
        // animator allows to change the position of our AR message due to movement of iphone
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.setPositionCenter(point)
        }
        // Check if iphone is moving
        animator.addCompletion {
            switch $0 {
                // if animation is finished, do not move/reposition messages due to movement
                case .end:
                    self.arScreenSpace.shouldAnimateMessage = false
                default:
                    self.arScreenSpace.shouldAnimateMessage = true
            }
        }
        // above we prepared the animation
        // animator.startAnimation will start or resume the ability to animate messages
        animator.startAnimation()
    }
    
    // Updates the screen space position of an entity's screen space view to the current projection.
    func updateScreenPosition() {
        // Get projection
        guard let projection = projection else { return }
        // projectedPoint will get a point in the 3D space(AR) and convert point into a 2D space
        let projectedPoint = projection.projectedPoint
        // isEnabled let's us know if the user can see the message from their point of view in AR
        isEnabled = projection.isVisible
        // if isEnabled is true, do not hide entity
        // else, hide it
        view?.isHidden = !isEnabled
        // check if we need to reposition user message due to phone movement
        if shouldAnimate {
            // if yes, reposition the user's message
            animateTo(projectedPoint)
        } else {
            setPositionCenter(projectedPoint)
        }
    }
    
}
// Functionality for our 2D message in 3D space (AR world)
struct ARScreenSpace: Component {
    // user message
    var view: MessageView?
    // is user dragging message
    var userDragging = false
    // is user editing message
    var userEditing = false
    // should message relocate position
    var shouldAnimateMessage = false
    // 3D point converted to 2D
    var projection: Projection?
}

// gets projection of a point from the 3D space (AR) converts it to a 2D space
struct Projection {
    let projectedPoint: CGPoint
    let isVisible: Bool
    
}

