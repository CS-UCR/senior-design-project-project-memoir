//
//  ProfileViewController.swift
//  ProjectM
//
//  Created by Bryan on 1/19/22.
//

import Foundation
import UIKit

private let reuseIdentifier = "ProfileRow"

class ProfileViewController: UIViewController {


    var tableView: UITableView!
    var profileImageHeader: ProfileImageHeader!


    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfilePage()
    }


    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60

        tableView.register(ProfileRow.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame

        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        profileImageHeader = ProfileImageHeader(frame: frame)
        tableView.tableHeaderView = profileImageHeader
        tableView.tableFooterView = UIView()
    }


    func configureProfilePage(){
        configureTableView()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        //navigationController?.navigationBar.barTintColor = UIColor(red: 205/255, green: 255/255, blue: 217/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 205/255, green: 255/255, blue: 217/255, alpha: 1)

        navigationItem.title = "Profile"
    }

}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileRow
        return cell
    }


}
