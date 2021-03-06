//
//  ViewController.swift
//  ProjectM
//
//  Created by Carlos Loeza on 10/8/21.
//


import UIKit
class LoginViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // set our background to white
        view.backgroundColor = UIColor.white
    }
    
    // Test API calls
    // creates and gets autogenerated id from anchor
    func testCreateAnchor(authorId: String){
        let newAnchor = CreateAnchorInput(lat: 1.0, long: 1.0, alt: 1.0, message: "this is a test message for a test anchor", authorId: authorId)
        
        Network.shared.apollo.perform(mutation: CreateAnchorMutation(anchorInput: newAnchor)) {
            result in
            switch result {
            case .success(let graphQLResult):
                guard let anchorData = graphQLResult.data?.createAnchor
                else {
                    print("LOG ERROR - testCreateAnchor GraphQL request: \(graphQLResult.errors.debugDescription)")
                    break
                }
            case .failure(let error):
                print("LOG ERROR - testCreateAnchor perform \(error)")
            }
        }
    }
    
    // gets message from anchor
    func testGetAnchor(anchorId: String) {
        Network.shared.apollo.fetch(query: GetAnchorByIdQuery(id: anchorId)) {
            result in
            switch result {
            case .success(let graphQLResult):
                
                guard let anchorData = graphQLResult.data?.getAnchor
                else {
                    print("LOG ERROR - testGetAnchor GraphQL request: \(graphQLResult.errors.debugDescription)")
                    break
                }
                let authorId = anchorData.authorId ?? "no author found"
                let message = anchorData.message ?? "no message found"
                print("LOG - testGetAnchor queried: \(anchorData.id)")
                print("LOG - testGetAnchor message: \"\(message)\" from userID: \(authorId)")
            case .failure(let error):
                print("LOG ERROR - testGetAnchor fetch \(error)")
            }
        }
    }
    
    // Just for testing
    @IBAction func TestAPI(_ sender: Any) {
        
        // run other local api tests (NOTE these are not synchronous!)
        testCreateAnchor(authorId: "richard-user-id")
        testGetAnchor(anchorId: "38c3f92d-b987-488c-a299-490a2654d02b")
        
        // alert test - confirm api call is functioning
        let uniqueId = "richard-user-id"
        let userData = CreateUserInput(id: uniqueId, username: "richard")
        Network.shared.apollo.perform(mutation: CreateUserMutation(userInput: userData)) {
            result in
            switch result {
            case .success(let graphQLResult):
              
              let errors = graphQLResult.errors
              let userData = graphQLResult.data?.createUser
              
              var alert: UIAlertController
              if errors != nil {
                  alert = UIAlertController(title: "ERROR CREATE DUPLICATE USER", message: "attempted to create another user with the same id: \(uniqueId)", preferredStyle: .alert)
              } else {
                  alert = UIAlertController(title: "CREATE USER SUCCESSFUL", message: userData.debugDescription, preferredStyle: .alert)
              }

              alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
              NSLog("The \"OK\" alert occured.")
              }))

              self.present(alert, animated: true, completion: nil)

            case .failure(let error):
                print("Failure! Error: \(error)")
          }
        }
    }
    
    // if user clicks on explore button perform segue
    // from login page to AR page
    @IBAction func exploreButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "explore", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


