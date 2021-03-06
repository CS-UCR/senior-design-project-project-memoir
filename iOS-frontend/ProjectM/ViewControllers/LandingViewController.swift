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

        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        
        authorizationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true;

        authorizationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true;
        
        
        authorizationButton.widthAnchor.constraint(equalToConstant: 250).isActive = true;
        authorizationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
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
            
            let uniqueId = credentials.user;
            
            Network.shared.apollo.fetch(query: GetUserByIdQuery(id: uniqueId)){
                result in
                switch result {
                case .success(let graphQLResult):
                    
                    guard let userData = graphQLResult.data?.getUser
                    else{
                        print("LOG ERROR - getUserData GraphQL request: (graphQLResult.errors?.debugDescription)")
                        break
                    }
                    
                    let userToken = userData.id ?? nil
                    let username = userData.username ?? nil
                    
                    if(userToken != nil){
                        UserDefaults.standard.set(userToken, forKey: "userToken")
                        self.performSegue(withIdentifier: "has_account_segue", sender: self)
                    }
                    
                case .failure(let error):
                    print("Failure to retrieve user data!")
                }
            }
            
            if(firstName != nil){
                UserDefaults.standard.set(uniqueId, forKey: "userToken")
                UserDefaults.standard.set(firstName, forKey: "firstName")
                self.performSegue(withIdentifier: "new_account_segue", sender: self)
            }
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
