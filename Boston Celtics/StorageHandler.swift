//
//  StorageHandler.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/27/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation

class StorageHandler{
    static let shared: StorageHandler = StorageHandler();
    
    var players: [Player] = [Player]();
    
    private init(){
        self.players = self.load();
//        players.append(Player(playerName: "Jaylen Brown", playerNumber: "7", playerPosition: "SG", playerCollege: "California"))
//        players.append(Player(playerName: "Carsen Edwards", playerNumber: "4", playerPosition: "PG", playerCollege: "Purdue"))
//        players.append(Player(playerName: "Tacko Fall", playerNumber: "99", playerPosition: "C", playerCollege: "UCF"))
//        players.append(Player(playerName: "Javonte Green", playerNumber: "43", playerPosition: "SG", playerCollege: "Radford"))
//        players.append(Player(playerName: "Gordon Hayward", playerNumber: "20", playerPosition: "SF", playerCollege: "Butler"))
//        players.append(Player(playerName: "Enes Kanter", playerNumber: "11", playerPosition: "C", playerCollege: "Kentucky"))
//        players.append(Player(playerName: "Romeo Langford", playerNumber: "45", playerPosition: "SG", playerCollege: "Indiana"))
//        players.append(Player(playerName: "Semi Ojeleye", playerNumber: "37", playerPosition: "PF", playerCollege: "SMU"))
//        players.append(Player(playerName: "Vincent Poirier", playerNumber: "77", playerPosition: "C", playerCollege: "---"))
//        players.append(Player(playerName: "Marcus Smart", playerNumber: "36", playerPosition: "PG", playerCollege: "Oklahoma State"))
//        players.append(Player(playerName: "Jayson Tatum", playerNumber: "0", playerPosition: "PF", playerCollege: "Duke"))
//        players.append(Player(playerName: "Daniel Theis", playerNumber: "27", playerPosition: "C", playerCollege: "---"))
//        players.append(Player(playerName: "Kemba Walker", playerNumber: "8", playerPosition: "PG", playerCollege: "Connecticut"))
//        players.append(Player(playerName: "Brad Wanamaker", playerNumber: "9", playerPosition: "PG", playerCollege: "Pittsburgh"))
//        players.append(Player(playerName: "Tremont Waters", playerNumber: "51", playerPosition: "PG", playerCollege: "LSU"))
//        players.append(Player(playerName: "Grant Williams", playerNumber: "12", playerPosition: "PF", playerCollege: "Tennessee"))
//        players.append(Player(playerName: "Robert Williams III", playerNumber: "44", playerPosition: "C", playerCollege: "Texas A&M"))
    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: players, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "players")
        }
    }
    
    func load() -> [Player] {
        let defaults = UserDefaults.standard
        if let savedPlayers = defaults.object(forKey: "players") as? Data {
            if let decodedPlayers = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPlayers) as? [Player] {
                return decodedPlayers.sorted(by: { $0.playerName < $1.playerName })
            }
        }
        return [Player]()
    }
    
}

