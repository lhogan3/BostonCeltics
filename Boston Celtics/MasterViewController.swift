//
//  MasterViewController.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/2/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import UIKit

//Defining the MasterViewController class. This class controls the TableView and what is displayed here.
class MasterViewController: UITableViewController {

    
    //Define a detailViewController object to be nil. This will be defined later.
    var detailViewController: DetailViewController? = nil;
    
    //The objects array will be used to store the data that is displayed in the list. This data is retrieved from the
    //StorageHandler class by loading the data that was stored from the last save() call.
    var objects = StorageHandler.shared.load();

    //This is what loads what the user sees on the screen.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view. This line creates the edit button in the top left of the screen.
        navigationItem.leftBarButtonItem = editButtonItem

        //This created the add button which calls the insertNewObject function when clicked.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        //This applies to the view being split, which wouuld be used with a Tablet.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    //This will be called to clear the last instance of the view.
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    //Defining the insertNewObject function.
    @objc
    func insertNewObject(_ sender: Any) {
        //When this function is called, (when clicking on the + button), it will segue to the AddPlayerViewController.
        performSegue(withIdentifier: "showAddPlayer", sender: self)
    }

    // MARK: - Segues

    //This sets the information for when the segue is the "showDetail" segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            //set the indexPath to be the item that was clicked.
            if let indexPath = tableView.indexPathForSelectedRow {
                //Set the object to be the one selected from the list.
                let object = objects[indexPath.row]
                
                //Let the controller be the detailViewController as that is where the segue is going to be going to.
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                //Set the necessary attributes, including the detail item that is going to be displayed to be the object that was
                //selected from the list.
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                //Finally, set the detailViewController that was defined at the top to be the one created by the function.
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    //Set the number of sections for the Table View to be 1.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Set the number of rows in the Table View to be the number of items in Objects.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    //This function is what is going to actually create the Table View.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //If the number of the row is even, then use the GrayCell created in the Storyboard.
        if(indexPath.row % 2 == 0){
            
            //Since we know that the number of the row is even, we are going to use the GrayCell.
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrayCell", for: indexPath) as! PlayerUITableViewCell
            
            //Set the object to be the one that is stored at that index in the objects array.
            let object = objects[indexPath.row];
            
            //Set the displayed player name and player number to be the one that is stored in the object.
            cell.grayPlayerName.text! = object.playerName;
            cell.grayPlayerNumber.text! = object.playerNumber;
            
            //If the player is a real player that is on the team, their picture is in the Assets folder.
            //Check to see if the player is real by looking for their name in the array of names in the StorageHandlerClass.
            if(StorageHandler.shared.playersForChecking.contains(object.playerName)){
                
                //If the player is real, then find their picture by their name and set that to be the picture displayed.
                cell.grayPlayerPhoto.image = UIImage(named: object.playerName);
            }
                
            //Otherwise, set the picture to be displayed to be the Celtics Logo.
            else{
                cell.grayPlayerPhoto.image = UIImage(named: "logo");
            }
            
            //Set the other attributes for the player to be the ones stored in the object.
            cell.playerName = object.playerName;
            cell.playerNumber = object.playerNumber;
            cell.playerPosition = object.playerPosition;
            cell.playerCollege = object.playerCollege;

            //Finally, set the index of the player in the list to be the row that they were placed in.
            object.index = indexPath.row;
            
            //Then return the cell for it to be displayed.
            return cell
        }
        
        //If the row is odd, then we are going to use the black cell.
        else {
            
            //Create the black cell.
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlayerUITableViewCell;
            
            //Set the object to be the one that is stored at that index in the objects array.
            let object = objects[indexPath.row];
            
            //Set the displayed player name and player number to be the one that is stored in the object.
            cell.playerNameLabel.text! = object.playerName;
            cell.playerNumberLabel.text! = object.playerNumber;
            
            //If the player is a real player that is on the team, their picture is in the Assets folder.
            //Check to see if the player is real by looking for their name in the array of names in the StorageHandlerClass.
            if(StorageHandler.shared.playersForChecking.contains(object.playerName)){
                cell.playerPhoto.image = UIImage(named: object.playerName);
            }
                
            //Otherwise, set the picture to be displayed to be the Celtics Logo.
            else{
                cell.playerPhoto.image = UIImage(named: "logo");
            }
            
            //Set the other attributes for the player to be the ones stored in the object.
            cell.playerName = object.playerName;
            cell.playerNumber = object.playerNumber;
            cell.playerPosition = object.playerPosition;
            cell.playerCollege = object.playerCollege;
            
            //Finally, set the index of the player in the list to be the row that they were placed in.
            object.index = indexPath.row;
            
            //Then return the cell to be displayed.
            return cell
        }

    }

    //This function is for when the edit button is clicked in the top left.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //If the user chooses to delete a player, present them with an alert.
        if editingStyle == .delete {
            
            //Define the alert.
            let alert = UIAlertController(title: "Are you sure you want to delete this player?", message: "This cannot be undone.", preferredStyle: .alert)
            
            //Define the default action to be if the player confirms their choice to delete a player.
            let defaultAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                
                //First, delete the selected player both from the players array in the StorageHandler, and then again in the objects array
                //for the Master View.
                StorageHandler.shared.players.remove(at: indexPath.row);
                self.objects.remove(at: indexPath.row)
                
                //Then, save the new array in StorageHandler.
                StorageHandler.shared.save();
                
                //Then, delete the row in the TableView.
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                //Finally, reindex the objects in the objects array by setting them with the following forEach loop.
                let count = 0;
                self.objects.forEach { object in
                    object.index = count;
                }
            }
            
            //Add this previously defined defaultAction.
            alert.addAction(defaultAction)
            
            //Create the cancel action, and have it do nothing. No action needed.
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            //Present the alert to the user.
            self.present(alert, animated: true)
        }
    }
}
