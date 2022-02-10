//
//  VC+ARCoachingDelegate.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/6/21.
//

import ARKit


extension ARViewController: ARCoachingOverlayViewDelegate {
    // Call this function to display AR coaching overlay
    // AR coaching overlay is the visual example which shows the user how to get an acceptable surface
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        // While our AR coaching overlay is being shown, do not show error message
        errorMessageLabel.ignoreErrorMessages = true
        errorMessageLabel.isHidden = true
        
        // Do not let the user interact with the screen while AR coaching overlay is being shown
        view.isUserInteractionEnabled = false
        
        // Make sure user is not editing a message while the AR coaching overlay appears on the screen
        // for loop will cycle through our messages and find any being edited
        // If user is editing message, stop them from editing
        for message in userMessages where message.isEditing {
            message.shouldAnimate = true
            // stop user from editing
            message.isEditing = false
            guard let messageView = message.view else { return }
            // dismiss keyboard if user was editing a message
            messageView.textView.dismissKeyboard()
        }
    }
    
    // Call this function once our AR coaching overlay is finished
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        // Do not ignore error message since our coaching overlay is done
        errorMessageLabel.ignoreErrorMessages = false
        // Allow user to interact with screen
        // Ex: create, delete, or drag message
        view.isUserInteractionEnabled = true
    }
    
    
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        runARSession()
    }
    
}

