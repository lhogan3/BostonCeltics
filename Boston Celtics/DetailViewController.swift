//
//  DetailViewController.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/2/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import UIKit

//Defining the DetailViewController class.
class DetailViewController: UIViewController {
    
    //Linking the elements on the screen created in the Storyboard. These include the labels, and the image of the player.
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerCollegeLabel: UILabel!
    @IBOutlet weak var deletePlayer: UIToolbar!
    @IBOutlet weak var playerPhoto: UIImageView!
    
    
    //Once the data from the detail item is loaded, this sets all of the information on the screen.
    func configureView() {
        //Update the user interface for the detail item by setting the labels to be the information from the Player object.
        if let detail = detailItem {
            if let label = playerNameLabel {
                label.text = detail.playerName
            }
            if let label = playerNumberLabel {
                label.text = detail.playerNumber
            }
            if let label = playerPositionLabel {
                label.text = detail.playerPosition
            }
            if let label = playerCollegeLabel {
                label.text = detail.playerCollege
            }
            
            //For the player photo, if the player is real, then display the player's picture by looking it up by their name.
            //Otherwise, display the celtics logo.
            if let photo = playerPhoto {
                if(StorageHandler.shared.playersForChecking.contains(detail.playerName)){
                    photo.image = UIImage(named: detail.playerName);
                }
                else{
                    photo.image = UIImage(named: "logo");
                }
            }
        }
    }

    //Load the view that the user sees.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    //This is the Player object that is being displayed. It was set in the segue from the Master View.
    var detailItem: Player?{
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    //This is the function that is called when the trashcan is clicked in the bottom left of the screen.
    @IBAction func deletePlayer(_ sender: Any) {
        
        //Define the alert.
        let alert = UIAlertController(title: "Are you sure you want to delete this player?", message: "This cannot be undone.", preferredStyle: .alert)
        
        //Define the default action to be if the player confirms their choice to delete a player.
        let defaultAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            
            //First, delete the selected player from the players array in the StorageHandler.
            //Then, save the new array to memory.
            StorageHandler.shared.players.remove(at: self.detailItem!.index);
            StorageHandler.shared.save();
            
            //Since the item is deleted, segue back to the master view with the player being deleted.
            self.performSegue(withIdentifier: "backToMaster", sender: self);
        }
        
        //Add this previously defined defaultAction.
        alert.addAction(defaultAction)
        
        //Create the cancel action, and have it do nothing. No action needed.
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //Present the alert to the user.
        self.present(alert, animated: true)
    }
    
    //Override the prepare function to set the item in the EditPlayerViewController to be the player being displayed currently in the Detail View.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //If we are moving to the EditPlayer screen...
        if segue.identifier == "toEditPlayer"{
            
            //Set the destination to the the EditPlayerViewController
            let vc = segue.destination as! EditPlayerViewController;
            
            //Then, set the player being displayed there to be the one being displayed here.
            vc.currentPlayer = self.detailItem!;
        }
    }

    //This function is called if the pencil is clicked in the bottom right of the screen.
    @IBAction func editPlayer(_ sender: Any) {
        
        //Segue to the EditPlayerViewController. 
        performSegue(withIdentifier: "toEditPlayer", sender: self)
    }
    
}
