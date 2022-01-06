//
//  ErrorMessageLabel.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/2/21.
//

import UIKit

@IBDesignable
class ErrorMessageLabel: UILabel {
    
    var ignoreErrorMessages = false
        
    override func drawText(in rect: CGRect) {
        // insets will shape our error message label
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
    
    // Display error message for user
    // Let user know no surface detected
    // text: contains string with the error message
    func displayErrorMessage(_ text: String, duration: TimeInterval = 3.0) {
        // If ignoreMessage is false, check if parameter text is empty
        guard !ignoreErrorMessages else { return }
        // if text is not empty, return
        // else, hide our error message label
        guard !text.isEmpty else {
            DispatchQueue.main.async {
                self.isHidden = true
                self.text = ""
            }
            return
        }
        // show our error message
        DispatchQueue.main.async {
            self.isHidden = false
            self.text = text
        }
        
        // Use tag to tell if the label has been updated.
        let tag = self.tag + 1
        self.tag = tag
        
        // Show error label if we need to show error message before we finish running the task
        // Prevents the error message from having a delay when appearing
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            if self.tag == tag {
                self.isHidden = true
            }
        }
    }
}



