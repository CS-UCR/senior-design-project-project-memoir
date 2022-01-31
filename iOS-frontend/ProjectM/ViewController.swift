//
//  ViewController.swift
//  ProjectM
//
//  Created by Carlos Loeza on 10/8/21.
//

import AuthenticationServices
import UIKit

class ViewController: UIViewController {

    private let authorizationButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(authorizationButton)
        authorizationButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        authorizationButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        authorizationButton.center = view.center
    }

     @objc func didTapSignIn(){
         // Grab provider object from AppleID kit
         let provider = ASAuthorizationAppleIDProvider()
         
         // Requests information from user's Apple Account
         let request = provider.createRequest()
         request.requestedScopes = [.fullName, .email]
         
         let controller = ASAuthorizationController(authorizationRequests: [request])
         
         // Perform Requests
         controller.delegate = self
         controller.presentationContextProvider = self
         controller.performRequests()
     }

}

// Handles Authorization delegation if error or success
extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential{
        case let credentials as ASAuthorizationAppleIDCredential:
            let firstName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.familyName
            let email = credentials.email
            
            break
        default:
            break
        }
    }
}


// Handles
extension ViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
