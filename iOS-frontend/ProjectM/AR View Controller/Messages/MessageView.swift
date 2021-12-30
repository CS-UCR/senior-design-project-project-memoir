//
//  MessageView.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/1/21.
//

import UIKit


// Create the appearance of our user message
class MessageView: UIView{
    // Displays text and supports text editing
    var textView: UITextView!
    // Allows userMessage to access MessageEntity methods.
    weak var userMessage: MessageEntity!
    // Apply a blurry background when user is typing
    var blurBackground: UIVisualEffectView!
    // Checks if placeholder inside our message box is removed (Ex: "New Message...")
    var placeHolderRemoved = false
    // Hold the offset of panning location and original view location (used in VC+UserGestures->panUserMessage())
    var xOff: CGFloat = 0
    var yOff: CGFloat = 0
    // Save the last frame that required no editing
    var lastFrame: CGRect!
    
    // Build MessageView given the specified frame and its associated message(Ex:MessageEntity).
    init(frame: CGRect, user_message: MessageEntity) {
        super.init(frame: frame)
        userMessage = user_message
        setupBlurBackgroundContainer()
        setupTextbox()
        lastFrame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup the blur background for our message
    fileprivate func setupBlurBackgroundContainer() {
        // create blur background
        blurBackground = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        // We will set the constraints manually so set auto resizing to false
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        // Move view to the top of all our views
        self.addSubview(blurBackground)
        // top anchor
        blurBackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        // left anchor
        blurBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        // right anchor
        blurBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        // bottom anchor
        blurBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // Draw rounded corners around message box
        blurBackground.layer.cornerRadius = 20
        blurBackground.layer.masksToBounds = true
    }
    
    // setup our text box so user can type a new message
    fileprivate func setupTextbox() {
        // spacing for our box along the edges
        let edgeSpacing: CGFloat = 30
        // Allows user to edit and write message
        textView = UITextView()
        // We will set the constraints manually so set auto resizing to false
        textView.translatesAutoresizingMaskIntoConstraints = false
        // Add a subview to the child of parent
        // In our case, place our message box on top of blurView
        blurBackground.contentView.addSubview(textView)
        // Set our constraints similar to blurBackground except add padding.
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: blurBackground.contentView.topAnchor, constant: edgeSpacing),
            textView.leadingAnchor.constraint(equalTo: blurBackground.contentView.leadingAnchor, constant: edgeSpacing),
            textView.trailingAnchor.constraint(equalTo: blurBackground.contentView.trailingAnchor, constant: -edgeSpacing),
            textView.bottomAnchor.constraint(equalTo: blurBackground.contentView.bottomAnchor, constant: -edgeSpacing)
        ])
        // set to clear since our background will be blurred
        textView.backgroundColor = .clear
        // set font for our message
        textView.font = UIFont(name: "Helvetica", size: 22)
        // align text to the left
        textView.textAlignment = .left
        // add done button to the top right of keyboard, so user can close keyboard
        textView.addDoneButton()
        // place holder
        textView.text = "New Message..."
        textView.textColor = .darkGray
    }
    
}

