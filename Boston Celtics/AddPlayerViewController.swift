//
//  AddPlayerViewController.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 4/9/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation
import UIKit

//Defining the AddPlayerViewController
class AddPlayerViewController: UIViewController, UITextFieldDelegate{
    
    //This ViewController controls the screen where the user can add a player to the list.
    
    //Links for the elements in the Storyboard. This includes the four text fields being filled out and the submit button.
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerNumber: UITextField!
    @IBOutlet weak var playerPosition: UITextField!
    @IBOutlet weak var playerCollege: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    //This is the function that is called when the submit button is pressed.
    @objc
    @IBAction func addPlayer() -> Void{
        
        //Set all of the fields for the new player to be added to the list with the updated values.
        let newPlayerName = playerName.text!;
        let newPlayerNumber = playerNumber.text!;
        let newPlayerPosition = playerPosition.text!;
        let newPlayerCollege = playerCollege.text!;
        
        //Then use these new fields to create the new player object using the constructer.
        let newPlayer = Player(playerName: newPlayerName, playerNumber: newPlayerNumber, playerPosition: newPlayerPosition, playerCollege: newPlayerCollege);
        
        //Add the player to the end of the list, and then save this to memory.
        StorageHandler.shared.players.append(newPlayer);
        StorageHandler.shared.save();
        
        //Finally, segue back to the master view with the new player successfully added to the list.
        performSegue(withIdentifier: "backToTable", sender: self);
    }
    
    //This is what loads what the user sees on the screen.
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //Make the delegate for the numberInput field equal to self, and then make sure that the sbumit button
        //is set to diabled when the view first loads as no changes have been made.
        playerNumber.delegate = self;
        submitButton.isEnabled = false;
        
        //Set the input methods for all of the text fields to be the editingChanged() function.
        playerName.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        playerNumber.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        playerPosition.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        playerCollege.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
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
            let name = playerName.text, !name.isEmpty,
            let number = playerNumber.text, !number.isEmpty,
            let position = playerPosition.text, !position.isEmpty,
            let college = playerCollege.text, !college.isEmpty
            else{
                self.submitButton.isEnabled = false;
                return
        }
        
        //Finally, with all of these conditions being met, make the submit button enabled.
        submitButton.isEnabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        //disposes of resources that can be recreated.
    }
}
