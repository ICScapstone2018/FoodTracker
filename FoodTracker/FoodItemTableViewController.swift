//
//  FoodItemTableViewController.swift
//  FoodTracker
//
//  Created by Renz on 2018-02-16.
//  Copyright © 2018  Kerensa E Mattison. All rights reserved.
//

import UIKit
import os

class FoodItemTableViewController: UITableViewController {
    var items = [FoodItem]()
    let cellIdentifier = "FoodItemTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        if let restored = loadItems() {
            items += restored
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodItemTableViewCell else {
            fatalError("Selected cell is not of type \(cellIdentifier)")
        }
        
        let item = items[indexPath.row]
        cell.photoImage.image = item.image
        cell.expiryIndicator.setIndicatorPercentage(date: item.expiryDate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            saveItems()
        }
    }
    
  //  @IBAction func unwindToFoodItemList(sender: UIStoryboardSegue) {
    //    if let sourceViewController = sender.source as? ViewController, let item = sourceViewController.item {
    //        let newIndexPath = IndexPath(row: items.count, section: 0)
    //        items.append(item)
     //       tableView.insertRows(at: [newIndexPath], with: .automatic) //iOS picks animation
     //   }
   // }
    @IBAction func unwindToFoodItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let item = sourceViewController.item {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Edit
                items[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add
                debugPrint("at start of add")
                let newIndexPath = IndexPath(row: items.count, section: 0)
                debugPrint("before appending item")
                items.append(item)
                debugPrint("after appending item")
                tableView.insertRows(at: [newIndexPath], with: .automatic) //iOS picks animation
                debugPrint("after appending")
                saveItems()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowItem" {
            guard let detailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination \(segue.destination)")
            }
            guard let selectedTableViewCell = sender as? FoodItemTableViewCell else {
                fatalError("Unexpected destination \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedTableViewCell) else {
                fatalError("Unexpected index path for \(selectedTableViewCell)")
            }
            detailViewController.item = items[indexPath.row]
            }
        }
    
    func saveItems() {
        if !NSKeyedArchiver.archiveRootObject(items, toFile: FoodItem.archiveURL.path) {
            os_log("Cannot save in %@", log: OSLog.default, type: .debug, FoodItem.archiveURL.path)
        }
    }
    
    func loadItems() -> [FoodItem]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: FoodItem.archiveURL.path) as? [FoodItem]
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
   
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
