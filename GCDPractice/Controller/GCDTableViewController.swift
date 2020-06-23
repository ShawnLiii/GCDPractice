//
//  GCDTableViewController.swift
//  GCDPractice
//
//  Created by Shawn Li on 6/19/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit

class GCDTableViewController: UITableViewController
{
    let userViewModel = UserViewModel()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        userViewModel.updateClosure = tableView.reloadData
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userViewModel.profiles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell
        let index = indexPath.row
        
        userViewModel.getImage(url: userViewModel.profiles[index].avatar)
        { (image) in
            cell.configureUserTextInfo(name: self.userViewModel.profiles[index].first_name, id: self.userViewModel.profiles[index].id, email: self.userViewModel.profiles[index].email, image: image)
        }

        return cell
    }    
}

