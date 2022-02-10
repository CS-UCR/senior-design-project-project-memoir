//
//  UIView.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/2/21.
//

import UIKit

// our extension allows us to edit and behaviour to UIView
extension UIView{
    
    // Allow our message to become bigger if user is editing message
    func fadeIn(duration: TimeInterval) {
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            // set background to black transparent so user can focus on message
            self.alpha = 1
        }.startAnimation()
    }
    
    // Allow our message to become smaller if user is not editing message
    func fadeOut(duration: TimeInterval) {
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            // set background to clear since user is done editing message
            self.alpha = 0
        }.startAnimation()
    }
    
    // Loop through all of our messageViews (Ex: messages posted by user in AR world) until we find the message being edited
    func firstSuperViewOfType<T: UIView>(_ type: T.Type) -> T? {
        // get view
        var view: UIView? = self
        // while our mesage view is not empty
        while view != nil {
            // if we found our message view, break
            if view is T {
                break
            // else get the next message view
            } else {
                view = view?.superview
            }
        }
        // return view
        return view as? T
        }
}
