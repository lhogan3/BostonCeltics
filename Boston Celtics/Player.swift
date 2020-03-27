//
//  Player.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/25/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation


class Player{
    var playerName:String;
    var playerNumber:String;
    var playerPosition:String;
    var playerCollege:String;
    
    init(playerName:String, playerNumber:Int, playerPosition:String, playerCollege:String) {
        self.playerName = playerName;
        self.playerNumber = "\(playerNumber)";
        self.playerPosition = playerPosition;
        self.playerCollege = playerCollege;
    }
}
