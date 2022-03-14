//
//  CreateAccountViewController.swift
//  ProjectM
//
//  Created by Marco Alexi Sta Ana on 2/1/22.
//

import AuthenticationServices
import UIKit

class CreateAccountViewController:
    UIViewController{
    
    //let uniqueId:String = UserDefaults.standard.object(forKey: "userToken") as! String
    //let firstName:String = UserDefaults.standard.object(forKey: "name") as! String

    @IBOutlet weak var userInputForm: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    
    let firstName = UserDefaults.standard.object(forKey: "firstName")!
    let userToken = UserDefaults.standard.object(forKey: "userToken")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInputForm.text = firstName as! String
        print(firstName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateUserLabel()
    }

    func  animateUserLabel(){
        usernameLabel.text = ""
        let str = "Name? :)"
        
        for i in str {
            usernameLabel.text! += "\(i)"
            RunLoop.current.run(until: Date()+0.30)
        }
    }
    
    // Closes keyboard if user clicks on space
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func createUser(){
    
        print("creating account...")
        
        let userData = CreateUserInput(id: userToken as! String, username: userInputForm.text)
        UserDefaults.standard.set(userInputForm.text, forKey: "firstName")
        
        Network.shared.apollo.perform(mutation: CreateUserMutation(userInput: userData)) {
            result in
            switch result {
            case .success(let graphQLResult):
              
              let errors = graphQLResult.errors
              let userData = graphQLResult.data?.createUser
              
              var alert: UIAlertController
              if errors != nil {
                  alert = UIAlertController(title: "ERROR CREATE DUPLICATE USER", message: "attempted to create another user with the same id", preferredStyle: .alert)
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
    
    
    @IBAction func createAccountBtn(_ sender: Any) {
        createUser()
        print("Successfully created!")
    }
    
}
