//
//  DetailViewController.swift
//  Boston Celtics
//
//  Created by Liam Hogan on 3/2/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerCollegeLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = playerNameLabel {
                label.text = detail.playerName
            }
            if let label = playerNumberLabel {
                label.text = detail.playerNumber
            }
            if let label = playerPositionLabel {
                label.text = detail.playerPosition
            }
            if let label = playerCollegeLabel {
                label.text = detail.playerCollege
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: Player?{
        didSet {
            // Update the view.
            configureView()
        }
    }


}

