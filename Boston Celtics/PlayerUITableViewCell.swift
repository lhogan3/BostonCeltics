//
//  PlayerUITableViewCell.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/27/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import UIKit

class PlayerUITableViewCell: UITableViewCell{
    
    var playerName:String = "";
    var playerNumber:String = "";
    var playerPosition:String = "";
    var playerCollege:String = "";


    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    

}
