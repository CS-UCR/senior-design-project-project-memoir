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


