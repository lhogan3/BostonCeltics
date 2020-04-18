//
//  AddPlayerViewController.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 4/9/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation
import UIKit

class EditPlayerViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var nameEdit: UITextField!
    @IBOutlet weak var numberEdit: UITextField!
    @IBOutlet weak var positionEdit: UITextField!
    @IBOutlet weak var collegeEdit: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var currentPlayer:Player = Player(playerName: "", playerNumber: "", playerPosition: "", playerCollege: "");
    
    @objc
    @IBAction func addPlayer() -> Void{
        let newPlayerName = nameEdit.text!;
        let newPlayerNumber = numberEdit.text!;
        let newPlayerPosition = positionEdit.text!;
        let newPlayerCollege = collegeEdit.text!;
        
        let newPlayer = Player(playerName: newPlayerName, playerNumber: newPlayerNumber, playerPosition: newPlayerPosition, playerCollege: newPlayerCollege);
        newPlayer.index = currentPlayer.index;
        currentPlayer = newPlayer;
        
        StorageHandler.shared.players.remove(at: currentPlayer.index)
        StorageHandler.shared.players.insert(newPlayer, at: newPlayer.index);
        StorageHandler.shared.save();
        performSegue(withIdentifier: "backToDetail", sender: self);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        numberEdit.delegate = self;
        button.isEnabled = false;

        nameEdit.text! = currentPlayer.playerName;
        numberEdit.text! = currentPlayer.playerNumber;
        positionEdit.text! = currentPlayer.playerPosition;
        collegeEdit.text! = currentPlayer.playerCollege;
        
        nameEdit.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        numberEdit.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        positionEdit.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
        collegeEdit.addTarget(self, action: #selector(editingChanged), for: .editingChanged);
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
            let name = nameEdit.text, !name.isEmpty,
            let number = numberEdit.text, !number.isEmpty,
            let position = positionEdit.text, !position.isEmpty,
            let college = collegeEdit.text, !college.isEmpty
            else{
                self.button.isEnabled = false;
                return
        }
        button.isEnabled = true;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController;
        vc.detailItem = currentPlayer;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        //disposes of resources that can be recreated.
    }
    
    
    
}
