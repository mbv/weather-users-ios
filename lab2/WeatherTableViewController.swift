//
//  WeatherTableViewController.swift
//  lab2
//
//  Created by Konstantin Terehov on 2/13/17.
//  Copyright © 2017 Konstantin Terehov. All rights reserved.
//

import UIKit

protocol TableViewAsyncLoadDelegate {
    func updateAfterLoad()
    func showAlert(title: String, message:String)
}


class WeatherTableViewController: UITableViewController, TableViewAsyncLoadDelegate {
    @IBAction func reloadWeather(_ sender: Any) {
        WeatherModel.sharedInstance.reloadData();
    }
    func updateAfterLoad() {
        self.tableView.reloadData()
    }
    
    func showAlert(title: String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableCell")
        WeatherModel.sharedInstance.setDelegate(delegate:self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherModel.sharedInstance.getWeathers().count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableCell", for: indexPath) as! WeatherTableViewCell
     cell.labelKey.text = WeatherModel.sharedInstance.getWeathers()[indexPath.row].time
     cell.labelValue.text = WeatherModel.sharedInstance.getWeathers()[indexPath.row].temperature
     
     return cell
    }


}
