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
    
    // Just for testing
    @IBAction func TestAPI(_ sender: Any) {
        // fetch and confirm query is functioning
        Network.shared.apollo.fetch(query: TestQueryQuery()) { result in
          switch result {
          case .success(let graphQLResult):
             
              let alert = UIAlertController(title: "API CALL", message: graphQLResult.data?.getUser?.username, preferredStyle: .alert)

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


