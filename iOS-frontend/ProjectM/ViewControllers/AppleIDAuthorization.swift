////
////  AppleIDButtonAuthorizaiton.swift
////  ProjectM
////
////  Created by Carlos Loeza on 10/26/21.
////
//import AuthenticationServices
//import UIKit
//
//@IBDesignable
//class AppleIDAuthorization: UIButton{
//
//    public var authorizationButton = ASAuthorizationAppleIDButton()
//
//    // init's allow our button to used in storyboard
//    override public init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override public func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        // Create ASAuthorizationAppleIDButton
//        authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
//
//        // Show authorizationButton
//        addSubview(authorizationButton)
//
//        // Watch for button tap
//        authorizationButton.addTarget(self, action: #selector(authorizationAppleIDButtonTapped(_:)), for: .touchUpInside)
//
//
//        // Use auto layout to make authorizationButton follow the MyAuthorizationAppleIDButton's dimension
//        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            authorizationButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
//            authorizationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
//            authorizationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
//            authorizationButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
//        ])
//    }
//
//    // Handler when button is pressed
//    @objc func authorizationAppleIDButtonTapped(_ sender: Any) {
//        // Forward the touch up inside event to MyAuthorizationAppleIDButton
//        sendActions(for: .touchUpInside)
//        let provider = ASAuthorizationAppleIDProvider()
//        let request = provider.createRequest()
//
//        // Schema for what to request from Apple
//        request.requestedScopes = [.fullName, .email]
//
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//
//        // Perform Requests
//        controller.delegate = self
////      controller.presentationContextProvider = self
//        controller.performRequests()
//    }
//
//    // Adding functionality to Apple Login
//
//}
//
//// Handles Authorization delegation if error or success
//extension AppleIDAuthorization: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print("error")
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential{
//        case let credentials as ASAuthorizationAppleIDCredential:
//            print(credentials)
//
//            let firstName = credentials.fullName?.givenName
//            let lastName = credentials.fullName?.familyName
//            let email = credentials.email
//
//            let nextViewController = UITabBarController(nibName: "UITabBarController", bundle: nil)
//
////            self.inputViewController?.performSegue(withIdentifier: "new_account_segue", sender: self)
//
//            print(credentials.fullName)
//            print(email)
//            print("SUCCESS BBBBBBIBB")
//            break
//        default:
//            break
//        }
//    }
//}
//
//
//// Handles IPAD windows
////extension AppleIDAuthorization: ASAuthorizationControllerPresentationContextProviding{
////    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
////        return
////    }
////}
//
//
//
