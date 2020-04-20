//
//  Player.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/27/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation

//Defining the Player class.
class Player: NSObject, NSCoding{
    
    //Create the fields for a Player.
    var playerName:String;
    var playerNumber:String;
    var playerPosition:String;
    var playerCollege:String;
    var index:Int;
    
    //Define the constructor for a player. The index will be set when the player is added to the list in the MasterViewController.
    init(playerName:String, playerNumber:String, playerPosition:String, playerCollege:String) {
        self.playerName = playerName;
        self.playerNumber = playerNumber;
        self.playerPosition = playerPosition;
        self.playerCollege = playerCollege;
        self.index = 0;
    }
    
    //Defining the encode function.
    func encode(with coder: NSCoder) {
        
        //Give the informational parts of the player object being encoded a key so it can be retrieved in the decode.
        //Then the coder.encode() can be called on all of the fields.
        coder.encode(self.playerName, forKey: "name")
        coder.encode(self.playerNumber, forKey: "number")
        coder.encode(self.playerPosition, forKey: "position")
        coder.encode(self.playerCollege, forKey: "college")
       }
    
    //Defining how the information can be retrieved.
    required convenience init?(coder decoder: NSCoder){
        guard
            
            //Dedcode all of the information by the key given above, and then return all of the pieces of information as Strings.
            let name = decoder.decodeObject(forKey: "name") as? String,
            let number = decoder.decodeObject(forKey: "number") as? String,
            let position = decoder.decodeObject(forKey: "position") as? String,
            let college = decoder.decodeObject(forKey: "college") as? String
        else { return nil }
        
        //Finally, call the constructor with the information decoded.
        self.init(
            playerName: name,
            playerNumber: number,
            playerPosition: position,
            playerCollege: college)
    }
}
