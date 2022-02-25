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
        
        // Do not let the user interact with the screen while AR coaching overlay is being shown
        view.isUserInteractionEnabled = false
    }
    
    // Call this function once our AR coaching overlay is finished
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        // Do not ignore error message since our coaching overlay is done
        // Allow user to interact with screen
        // Ex: create, delete, or drag message
        self.placeExistingMessages()
        view.isUserInteractionEnabled = true
    }
    
    
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        runARSession()
    }
    
}

