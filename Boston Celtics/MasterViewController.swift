//
//  MasterViewController.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/2/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = StorageHandler.shared.load();


    override func viewDidLoad() {
        //objects = StorageHandler.shared.load();
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        performSegue(withIdentifier: "showAddPlayer", sender: self)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row % 2 == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrayCell", for: indexPath) as! PlayerUITableViewCell
            let object = objects[indexPath.row]
            cell.grayPlayerName.text! = object.playerName
            cell.grayPlayerNumber.text! = object.playerNumber;
            if(StorageHandler.shared.playersForChecking.contains(object.playerName)){
                cell.grayPlayerPhoto.image = UIImage(named: object.playerName);
            }
            else{
                cell.grayPlayerPhoto.image = UIImage(named: "logo");
            }
            cell.playerName = object.playerName;
            cell.playerNumber = object.playerNumber;
            cell.playerPosition = object.playerPosition;
            cell.playerCollege = object.playerCollege;
            
            object.index = indexPath.row;
            
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlayerUITableViewCell
            let object = objects[indexPath.row]
            cell.playerNameLabel.text! = object.playerName
            cell.playerNumberLabel.text! = object.playerNumber;
            if(StorageHandler.shared.playersForChecking.contains(object.playerName)){
                cell.playerPhoto.image = UIImage(named: object.playerName);
            }
            else{
                cell.playerPhoto.image = UIImage(named: "logo");
            }
            cell.playerName = object.playerName;
            cell.playerNumber = object.playerNumber;
            cell.playerPosition = object.playerPosition;
            cell.playerCollege = object.playerCollege;
            
            object.index = indexPath.row;
            
            return cell
        }

    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are you sure you want to delete this player?", message: "This cannot be undone.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                StorageHandler.shared.players.remove(at: indexPath.row);
                self.objects.remove(at: indexPath.row)
                StorageHandler.shared.save();
                tableView.deleteRows(at: [indexPath], with: .fade)
                let count = 0;
                self.objects.forEach { object in
                    object.index = count;
                }
            }
            alert.addAction(defaultAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else if editingStyle == .insert {
            print("happens when you touch the thing that you want to edit")
            
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
