//
//  CreateAccountViewController.swift
//  ProjectM
//
//  Created by Marco Alexi Sta Ana on 2/1/22.
//

import UIKit

class CreateAccountViewController: UIViewController{
    
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
