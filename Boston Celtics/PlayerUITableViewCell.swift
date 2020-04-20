//
//  PlayerUITableViewCell.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/27/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import UIKit

//Defining a custom UITableViewCell called PlayerUITableViewCell
class PlayerUITableViewCell: UITableViewCell{
    
    //Define the information that would be stored in the Player Object.
    var playerName:String = "";
    var playerNumber:String = "";
    var playerPosition:String = "";
    var playerCollege:String = "";

    //Defining the storyboard elements. This includes the name, number and playerPhoto
    //for both the normal Cell and GrayCell.
    @IBOutlet weak var grayPlayerPhoto: UIImageView!
    @IBOutlet weak var grayPlayerNumber: UILabel!
    @IBOutlet weak var grayPlayerName: UILabel!
    @IBOutlet weak var playerPhoto: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
}
