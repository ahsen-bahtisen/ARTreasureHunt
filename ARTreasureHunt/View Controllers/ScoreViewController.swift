//
//  ScoreViewController.swift
//  ARTreasureHunt
//
//  Created by Ahsen Bahtışen on 23.06.2023.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var treasureCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let score = defaults.integer(forKey: "UserScore")
        let treasureCount = defaults.integer(forKey: "TreasureCount")
        
        // View score and number of treasures
        scoreLabel.text = "\(score)"
        treasureCountLabel.text = "X\(treasureCount)"
    }
    

}
