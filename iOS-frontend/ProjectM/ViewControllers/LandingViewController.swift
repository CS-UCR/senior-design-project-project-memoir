// NOTE THIS CONTROLLER DOES NOTHING FOR NOW IGNORE

import AuthenticationServices
import UIKit

class LandingViewController: UIViewController {

    private let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)

    
    // After screen loads, add button and wath for tap of sign in page
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(authorizationButton)
        authorizationButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    // Handles generation of the apple id button within storyboard
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        authorizationButton.frame = CGRect(x: 68, y: 565, width: 250, height: 50)
//        authorizationButton.frame = CGRect(x: 0, y: 500, width: 250, height: 50)
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
//        authorizationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0)
        
//        NSLayoutConstraint.activate([
//            authorizationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
//            authorizationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
//            authorizationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
//            authorizationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
//        ])
        
//        authorizationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
//        authorizationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true;
        
        authorizationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true;
//        authorizationButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true;
        
//        authorizationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true;
//        authorizationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true;
        authorizationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true;
        
        
        authorizationButton.widthAnchor.constraint(equalToConstant: 250).isActive = true;
        authorizationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        
//        authorizationButton.constraint(equalToConstant: 50)
//        authorizationButton.constraints
        
        
    }

     // When sign in is clicked, execute requests to Apple (Delegations)
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
extension LandingViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error authorization")
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential{
        case let credentials as ASAuthorizationAppleIDCredential:
            let firstName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.familyName
            let email = credentials.email
            
            
            print("successful authorization")
            print(firstName)
            
            self.performSegue(withIdentifier: "new_account_segue", sender: self)
            
            break
        default:
            break
        }
    }
}


// Handles what to present in the view controller i.e. show window
extension LandingViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
