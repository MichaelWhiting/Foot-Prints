//
//  LocationViewController.swift
//  Foot Prints
//
//  Created by Boe Bogdin on 5/1/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase

class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource: [String] = ["Item 1", "Item2", "Item3"]
    
    @IBOutlet weak var UserstableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the table view's delegate and data source to self
        UserstableView.delegate = self
        UserstableView.dataSource = self
    }
    
    // MARK: - Table view data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the data source
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell or create a new one
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! UsersTableViewCell
        
        // Get the data for the current row from the data source
        let rowData = dataSource[indexPath.row]
        
        // Set the text of the label in the cell
        cell.Userslabel.text = rowData
        
        return cell
    }
    
    @IBOutlet weak var collectBadgeNumberLabel: UILabel!
    // MARK: - Table view delegate methods
    @IBAction func RatingSlider(_ sender: UISlider) {
    }
    @IBAction func Addthisbadgebutton(_ sender: Any) {
    }
    
    // Implement any necessary table view delegate methods here
    
    // MARK: - IBActions and IBOutlets
    
    // Connect any necessary IBActions and IBOutlets here
    class UsersTableViewCell: UITableViewCell {
        @IBOutlet weak var Userslabel: UILabel!
    }
    @IBOutlet weak var Locationslabel: UILabel!
}



