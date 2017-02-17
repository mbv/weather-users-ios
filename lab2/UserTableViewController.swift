//
//  UserTableViewController.swift
//  lab2
//
//  Created by Konstantin Terehov on 2/13/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableViewController: UITableViewController {
    
    //var selectedUserId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserModel.sharedInstance.getUsers().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as! UserTableViewCell
        let user = UserModel.sharedInstance.getUsers()[indexPath.row]
        
        cell.labelUserName.text = user.fullName
        cell.imageUser.sd_setImage(with: URL(string: user.image), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*selectedUserId = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailUserViewController")
        navigationController?.pushViewController(destination, animated: true)*/
        performSegue(withIdentifier: "segueDetailView", sender: navigationController!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueDetailView") {
            let detailViewController = segue.destination as! DetailUserViewController
            detailViewController.userId = self.tableView.indexPathForSelectedRow?.row
        }
    }

}
