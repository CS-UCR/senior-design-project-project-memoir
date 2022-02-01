//
//  Keyboard.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/6/21.
//

import UIKit

// extension allows us to edit the behavior of keyboardIsPoppingUp()
extension ARViewController {
    @objc
    // Gets the height of the keyboard every time it appears
    func keyboardIsPoppingUp(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Get the height of the keyboard once it appears on screen
            // We need the height to determine where we can place our message box when user is typing
            keyboardHeight = keyboardFrame.height
        }
    }
}

extension UITextView {
    // Adds a UIToolbar with a dismiss button as UITextView's inputAccesssoryView (which appears on top of the keyboard)
    // Add a 'Done' button on top left of keyboard. The 'Done' button lets use know the user is finished typing their message
    func addDoneButton() {
        // doneToolBar creates the toolbar above the keybaord so we can add our 'Done' button
        let doneToolBar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
        doneToolBar.barStyle = .default
        // doneButton represents the 'Done' button on the top left of keyboard
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        // Add doneButton to our tool bar
        doneToolBar.items = [doneButton]
        // Get buttom to appear on top of keyboard to make it clickable
        inputAccessoryView = doneToolBar
    }
    
    
    @objc
    // Set endEditing to true once we dismissKeyboard
    func dismissKeyboard() {
        endEditing(true)
    }
    
}

