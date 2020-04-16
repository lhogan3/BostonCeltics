//
//  Player.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/27/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation

class Player: NSObject, NSCoding{
    
    var playerName:String;
    var playerNumber:String;
    var playerPosition:String;
    var playerCollege:String;
    
    init(playerName:String, playerNumber:String, playerPosition:String, playerCollege:String) {
        self.playerName = playerName;
        self.playerNumber = playerNumber;
        self.playerPosition = playerPosition;
        self.playerCollege = playerCollege;
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(self.playerName, forKey: "name")
        coder.encode(self.playerNumber, forKey: "number")
        coder.encode(self.playerPosition, forKey: "position")
        coder.encode(self.playerCollege, forKey: "college")
       }
    
    required convenience init?(coder decoder: NSCoder){
        guard
            let name = decoder.decodeObject(forKey: "name") as? String,
            let number = decoder.decodeObject(forKey: "number") as? String,
            let position = decoder.decodeObject(forKey: "position") as? String,
            let college = decoder.decodeObject(forKey: "college") as? String
        else { return nil }
        self.init(
            playerName: name,
            playerNumber: number,
            playerPosition: position,
            playerCollege: college)
    }
}

