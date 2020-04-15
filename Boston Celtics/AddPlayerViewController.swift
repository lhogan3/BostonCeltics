//
//  AddPlayerViewController.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 4/9/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation
import UIKit

class AddPlayerViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerNumber: UITextField!
    @IBOutlet weak var playerPosition: UITextField!
    @IBOutlet weak var playerCollege: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @objc
    @IBAction func addPlayer() -> Void{
        let newPlayerName = playerName.text!;
        let newPlayerNumber = playerNumber.text!;
        let newPlayerPosition = playerPosition.text!;
        let newPlayerCollege = playerCollege.text!;
        
        let newPlayer = Player(playerName: newPlayerName, playerNumber: newPlayerNumber, playerPosition: newPlayerPosition, playerCollege: newPlayerCollege);
        
        StorageHandler.shared.players.append(newPlayer);
        performSegue(withIdentifier: "backToTable", sender: self);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        playerNumber.delegate = self;
        submitButton.isEnabled = false;
        
        playerName.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        playerNumber.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        playerPosition.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        playerCollege.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let allowedCharacters = CharacterSet.decimalDigits;
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    @objc func editingChanged(_ textField: UITextField){
        if textField.text?.count == 1{
            if textField.text?.first == " "{
                textField.text = "";
                return
            }
        }
        guard
            let name = playerName.text, !name.isEmpty,
            let number = playerNumber.text, !number.isEmpty,
            let position = playerPosition.text, !position.isEmpty,
            let college = playerCollege.text, !college.isEmpty
            else{
                self.submitButton.isEnabled = false;
                return
        }
        submitButton.isEnabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        //disposes of resources that can be recreated.
    }
    
    
    
}
