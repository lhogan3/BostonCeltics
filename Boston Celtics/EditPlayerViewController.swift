//
//  AddPlayerViewController.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 4/9/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation
import UIKit


//Defining the EditPlayerViewController class.
class EditPlayerViewController: UIViewController, UITextFieldDelegate{
    
    //This ViewController controls the screen where player data can be edited. It take in the information about
    //the player being edited and then fills the appropriate fields with this information.
    
    //Links for the elements in the Storyboard. This includes the four text fields being edited and then the submit button.
    @IBOutlet weak var nameEdit: UITextField!
    @IBOutlet weak var numberEdit: UITextField!
    @IBOutlet weak var positionEdit: UITextField!
    @IBOutlet weak var collegeEdit: UITextField!
    @IBOutlet weak var button: UIButton!
    
    //This is the Player Object that is the placeholder until the information is set for the player in the segue from the detail view.
    //This needs to be defined first to allow the information to be filled by the prepare() that was overrided in the detail view.
    var currentPlayer:Player = Player(playerName: "", playerNumber: "", playerPosition: "", playerCollege: "");
    
    //This is the function that is called when the submit button is pressed.
    @objc
    @IBAction func addPlayer() -> Void{
        
        //Set all of the fields for the new player to be added to the list with the updated values.
        let newPlayerName = nameEdit.text!;
        let newPlayerNumber = numberEdit.text!;
        let newPlayerPosition = positionEdit.text!;
        let newPlayerCollege = collegeEdit.text!;
        
        //Then use these new fields to create the new player object using the constructer.
        let newPlayer = Player(playerName: newPlayerName, playerNumber: newPlayerNumber, playerPosition: newPlayerPosition, playerCollege: newPlayerCollege);
        
        //Make sure that the index of the new player is set so that the player is still in the same spot in the list.
        newPlayer.index = currentPlayer.index;
        
        //Then make the new player be the current player, so the data is displayed correctly in the detail view.
        currentPlayer = newPlayer;
        
        //Remove the player that is currently at the index of the player being edited, then insert the updated player in the spot that the old player
        //was in originally. Then save this information for when the list is brought up again.
        StorageHandler.shared.players.remove(at: currentPlayer.index)
        StorageHandler.shared.players.insert(newPlayer, at: newPlayer.index);
        StorageHandler.shared.save();
        
        //Finally, segue back to the master view with the updated player successsfully added to the list.
        performSegue(withIdentifier: "backToMaster", sender: self);
    }
    
    //This is what loads what the user sees on the screen.
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //Make the delegate for the numberInput field equal to self, and then make sure that the sbumit button
        //is set to diabled when the view first loads as no changes have been made.
        numberEdit.delegate = self;
        button.isEnabled = false;

        //Set the text for all of the input fields to be the information that is currently set for that player.
        nameEdit.text! = currentPlayer.playerName;
        numberEdit.text! = currentPlayer.playerNumber;
        positionEdit.text! = currentPlayer.playerPosition;
        collegeEdit.text! = currentPlayer.playerCollege;
        
        //Set the input methods for all of the text fields to be the editingChanged() function.
        nameEdit.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        numberEdit.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        positionEdit.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        collegeEdit.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
    }
    
    //Create the allowed characters for the text fields that allow numerical and alphabetical characters, but make sure to limit the player
    //number field to only allow numbers. This function will return the allowed characters.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let allowedCharacters = CharacterSet.decimalDigits;
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    //Defining the editingChanged() function.
    @objc func editingChanged(_ textField: UITextField){
        
        //Check to see if the character count is one chracter.
        if textField.text?.count == 1{
            //Knowing that it is one character, is the first character a space?
            if textField.text?.first == " "{
                //If it is a space, take that space out and return the value of the empty string.
                textField.text = "";
                return
            }
        }
        
        //Check to see if all of the fields have some characters in them, otherwise return the submit button being disabled.
        guard
            let name = nameEdit.text, !name.isEmpty,
            let number = numberEdit.text, !number.isEmpty,
            let position = positionEdit.text, !position.isEmpty,
            let college = collegeEdit.text, !college.isEmpty
            else{
                self.button.isEnabled = false;
                return
        }
        
        //Finally, with all of these conditions being met, make the submit button enabled.
        button.isEnabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        //disposes of resources that can be recreated.
    }
}
