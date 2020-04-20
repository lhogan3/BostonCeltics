//
//  StorageHandler.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/27/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import Foundation

//Defining the StorageHandler class. This is where the the data that is loaded into the app is handled.
class StorageHandler{
    
    //Instantiation of the class itself that will be used in the MasterView.
    static let shared: StorageHandler = StorageHandler();
    
    //Define the players array to be empty.
    var players: [Player] = [Player]();
    
    //This array is an array that is never changed, and hass all of the names of the current players for the Boston Celtics. This is user throughout the app to
    //tell if the player's picture is stored in the assets folder. That way, if the picture is stored there, then it can be retrieved.
    let playersForChecking: [String] = ["Jaylen Brown", "Carsen Edwards", "Tacko Fall", "Javonte Green", "Gordon Hayward", "Enes Kanter", "Romeo Langford",
                                        "Semi Ojeleye", "Vincent Poirier", "Marcus Smart", "Jayson Tatum", "Daniel Theis", "Kemba Walker", "Brad Wanamaker", "Tremont Waters", "Grant Williams", "Robert Williams III"];
    
    //Constructor for the StorageHandler. This is done by calling the load() function.
    private init(){
        self.players = self.load();
    }
    
    //Defining the save function.
    func save() {
        
        //Takes the players array from the StorageHandler and saves it with the key "players". Then, sets the save location
        //to be the the UserDefaults.standard location. This is where the load() function will be searching for the data.
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: players, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "players")
        }
    }
    
    //Defining the load function, which returns the array of Player objects to be displayed in the app.
    func load() -> [Player] {
        
        //Setting the location to be searched to be UserDefaults.standard.
        let defaults = UserDefaults.standard
        
        //If there is saved data under the key "players", turn this into an array of Players.
        if let savedPlayers = defaults.object(forKey: "players") as? Data {
            if let decodedPlayers = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPlayers) as? [Player] {
                //If nothing is found, then initialize this with all of the current players with their information.
                if(decodedPlayers.isEmpty){
                    var players = [Player]();
                    players.append(Player(playerName: "Jaylen Brown", playerNumber: "7", playerPosition: "SG", playerCollege: "California"))
                    players.append(Player(playerName: "Carsen Edwards", playerNumber: "4", playerPosition: "PG", playerCollege: "Purdue"))
                    players.append(Player(playerName: "Tacko Fall", playerNumber: "99", playerPosition: "C", playerCollege: "UCF"))
                    players.append(Player(playerName: "Javonte Green", playerNumber: "43", playerPosition: "SG", playerCollege: "Radford"))
                    players.append(Player(playerName: "Gordon Hayward", playerNumber: "20", playerPosition: "SF", playerCollege: "Butler"))
                    players.append(Player(playerName: "Enes Kanter", playerNumber: "11", playerPosition: "C", playerCollege: "Kentucky"))
                    players.append(Player(playerName: "Romeo Langford", playerNumber: "45", playerPosition: "SG", playerCollege: "Indiana"))
                    players.append(Player(playerName: "Semi Ojeleye", playerNumber: "37", playerPosition: "PF", playerCollege: "SMU"))
                    players.append(Player(playerName: "Vincent Poirier", playerNumber: "77", playerPosition: "C", playerCollege: "---"))
                    players.append(Player(playerName: "Marcus Smart", playerNumber: "36", playerPosition: "PG", playerCollege: "Oklahoma State"))
                    players.append(Player(playerName: "Jayson Tatum", playerNumber: "0", playerPosition: "PF", playerCollege: "Duke"))
                    players.append(Player(playerName: "Daniel Theis", playerNumber: "27", playerPosition: "C", playerCollege: "---"))
                    players.append(Player(playerName: "Kemba Walker", playerNumber: "8", playerPosition: "PG", playerCollege: "Connecticut"))
                    players.append(Player(playerName: "Brad Wanamaker", playerNumber: "9", playerPosition: "PG", playerCollege: "Pittsburgh"))
                    players.append(Player(playerName: "Tremont Waters", playerNumber: "51", playerPosition: "PG", playerCollege: "LSU"))
                    players.append(Player(playerName: "Grant Williams", playerNumber: "12", playerPosition: "PF", playerCollege: "Tennessee"))
                    players.append(Player(playerName: "Robert Williams III", playerNumber: "44", playerPosition: "C", playerCollege: "Texas A&M"))
                    
                    //Once the array has been created, sort the array by the players' name and then return the array.
                    return players.sorted(by: { $0.playerName < $1.playerName })
                }
                else{
                    
                    //If there was data from the last session, then return this array sorted by the players' first name.
                    return decodedPlayers.sorted(by: { $0.playerName < $1.playerName })
                }
            }
        }
        //Should never reach this point, but if the searching did not work correctly then just return an empty array of type Player. 
        return [Player]()
    }
}
