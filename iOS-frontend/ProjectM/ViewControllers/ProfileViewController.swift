//
//  ProfileViewController.swift
//  ProjectM
//
//  Created by Bryan on 1/19/22.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var standardUIImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTable.register(UITableViewCell.self, forCellReuseIdentifier: "profileCell")
        profileTable.dataSource = self
        standardUIImage.layer.masksToBounds = true
        standardUIImage.layer.cornerRadius = standardUIImage.bounds.width / 2
        standardUIImage.image = UIImage(named: "chiliicon.png")
    }
}

let profileOptionsOne = ["Edit Profile ", "Log Out"]
let profileOptionsTwo = ["Notifications", "Email", "Report"]

extension ProfileViewController : UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int
        if(section == 0){
            count = profileOptionsOne.count
        } else {
            count = profileOptionsTwo.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
       let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        var labelTxt : String
        if(indexPath.section == 0){
            labelTxt = profileOptionsOne[indexPath.row]
        } else {
            labelTxt = profileOptionsTwo[indexPath.row]
        }
        cell.textLabel!.text = labelTxt

       return cell
    }
}



extension ProfileViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableTitles = ["Social", "Communications"]
        return tableTitles[section]
    }
}
