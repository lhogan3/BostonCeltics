//
//  StorageHandler.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/25/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation

class StorageHandler{
    static let shared:StorageHandler = StorageHandler();
    
    var players:[Player];
    
    private init(){
        players = [Player]()
    }
}
