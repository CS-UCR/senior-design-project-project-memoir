//
//  File.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/6/21.
//

import UIKit
import ARKit

extension ARViewController {
    // setup the UI for our AR screen
    func overlayUISetup(){
        // Setting up the shadeView, which is used to dim the camera feed when a user is editing message (helps to draw the user's focus).
        runARSession()
        
        setupShadeView()
        // Adding a clear button, the user should always be able to remove all messages in the AR Experience.
        addClearButton()
        // Adding the ARCoachingOverlayView, which helps guide users to establish tracking.
        addCoachingOverlay()
    
    }
    
    // setupShadeView() will create the shade view for our user when they type
    fileprivate func setupShadeView() {
        // create our shade view
        shadeView = UIView(frame: .zero)
        // Set constraints manually so set to false
        shadeView.translatesAutoresizingMaskIntoConstraints = false
        // Add to our shadeView as a child(subView) in our arView
        ARView.addSubview(shadeView)
        // Set constraints to covers expand to the each of each corner
        NSLayoutConstraint.activate([
            shadeView.topAnchor.constraint(equalTo: ARView.topAnchor),
            shadeView.leadingAnchor.constraint(equalTo: ARView.leadingAnchor),
            shadeView.trailingAnchor.constraint(equalTo: ARView.trailingAnchor),
            shadeView.bottomAnchor.constraint(equalTo: ARView.bottomAnchor)
        ])
        // create a light black shadeView
        shadeView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        // Make shadeView transparent
        shadeView.alpha = 0
    }


    // addClearButton() creates a button so user can remove all messages from screen
    fileprivate func addClearButton() {
        // create clear button
        let clearButton = UIButton()
        // set autoresizing to false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        // add clearButton to arView
        ARView.addSubview(clearButton)
        // set constraints
        NSLayoutConstraint.activate([
            clearButton.bottomAnchor.constraint(equalTo: ARView.safeAreaLayoutGuide.bottomAnchor),
            clearButton.trailingAnchor.constraint(equalTo: ARView.trailingAnchor, constant: -25)
        ])
        // set image for button
        clearButton.setImage(UIImage(imageLiteralResourceName: "clear"), for: .normal)
        clearButton.addTarget(self, action: #selector(userTappedClear(_:)), for: .touchUpInside)
        clearButton.alpha = 0.7
    }
    
    // Coaching overlay helps us validate we have a supported for our AR world
    fileprivate func addCoachingOverlay() {
        let coachingOverlay = ARCoachingOverlayView(frame: ARView.frame)
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        // add to the front so this is the only thing user will see
        ARView.addSubview(coachingOverlay)
        NSLayoutConstraint.activate([
            coachingOverlay.topAnchor.constraint(equalTo: ARView.topAnchor),
            coachingOverlay.leadingAnchor.constraint(equalTo: ARView.leadingAnchor),
            coachingOverlay.trailingAnchor.constraint(equalTo: ARView.trailingAnchor),
            coachingOverlay.bottomAnchor.constraint(equalTo: ARView.bottomAnchor)
        ])
        coachingOverlay.goal = .geoTracking
        coachingOverlay.session = ARView.session
        coachingOverlay.delegate = self
    }
}
