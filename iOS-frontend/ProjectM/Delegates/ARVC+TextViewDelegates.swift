//
//  VC+TextViewDelegates.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/2/21.
//



import UIKit
import ARKit

// extension allows us to add code to our ARViewController without adding too much code to a single file.
// UITextViewDelegate defines a set of optional methods that can get triggered when the text is being edited.
extension ARViewController: UITextViewDelegate {
    
    // User is about to start editing message
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Get the view for the message being editted.
        // Since there may be multiple messages on the screen, we need to find the correct view.
        guard let messageView = textView.firstSuperViewOfType(MessageView.self) else { return }

        // If any message is being dragged, stop it by marking it to false.
        for message in userMessages where message.isDragging { message.arScreenSpace.userDragging = false }
        // Remove the placeholder "New Message..." in our message box
        clearPlaceholderText(messageView, textView)
        // Bring our message to the front
        ARView.addSubview(messageView)
        // Set to true so user can write new message
        messageView.userMessage.isEditing = true
        // Enhance the user's focues on message by dimming the background when typing
        focusOnMessageView(messageView)

    }
    
    // User is done editing message
    func textViewDidEndEditing(_ textView: UITextView) {
        // get message user was editing
        guard let messageView = textView.firstSuperViewOfType(MessageView.self) else { return }

        // Access the text before deleting it
        // print(messageView.textView.text)
        messageView.textView.text = ""
        if let devicePosition = locationManager.location?.coordinate {
            self.addGeoLocationToAnchor(at: devicePosition)
        } else {
        }

        messageView.userMessage.shouldAnimate = true
        messageView.userMessage.isEditing = false

        unfocusOnMessageView(messageView)
    }
    
    // In order to make our function private, we add fileprivate infront
    // If we add 'private' instead, the function cannot be accessed outside of the class
    /*https://stackoverflow.com/questions/39027250/what-is-a-good-example-to-differentiate-between-fileprivate-and-private-in-swift*/
    func clearPlaceholderText(_ messageView: MessageView, _ textView: UITextView) {
        if !messageView.placeHolderRemoved {
            textView.text = ""
            textView.textColor = .white
            messageView.placeHolderRemoved = true
        }
    }
    
    // Set a black transparent background to allow user to foucs on message
    func focusOnMessageView(_ messageView: MessageView) {
        UIViewPropertyAnimator(duration: 0.2, curve: .easeIn) {
            // .alpha allows us to make our background transparent black so user can focus on message.
            // Setting .alpha to 1 means the highest transparent black, 0.0 means totally transparent
            self.shadeView.alpha = 1
        }.startAnimation()
        animateMessageViewToEdit(messageView)
    }
    
    // Remove the black transparent background from focusOnMessageView
    func unfocusOnMessageView(_ messageView: MessageView) {
        UIViewPropertyAnimator(duration: 0.4, curve: .easeIn) {
            self.shadeView.alpha = 0
            messageView.frame = messageView.lastFrame
            messageView.blurBackground.effect = UIBlurEffect(style: .dark)
            messageView.layoutIfNeeded()
        }.startAnimation()
    }

    // Animates our message by enlarging our message box to edit
    func animateMessageViewToEdit(_ messageView: MessageView) {
        // safeFrame holds the dimensions for the screen on our iphone
        let safeFrame = view.safeAreaLayoutGuide.layoutFrame
        // height holds the space where our message box will appear for user to type message
        // We get this by getting (the height our iphone screen) - (the height our keyboard)
        let height = safeFrame.height - keyboardHeight
        // insets helps create a cushion between our message and the screen borders
        // In our case, we are creating a cushion between keyboard and message box when user is editing
        let inset = height * 0.1
        // create message box using our inset measurement
        let editingFrame = CGRect(origin: safeFrame.origin, size: CGSize(width: safeFrame.width, height: height + 10)).insetBy(dx: inset, dy: inset)
        UIViewPropertyAnimator(duration: 0.2, curve: .easeIn) {
            // animate our message box
            messageView.frame = editingFrame
            messageView.blurBackground.effect = UIBlurEffect(style: .light)
            messageView.layoutIfNeeded()
        }.startAnimation()
    }
    
}

