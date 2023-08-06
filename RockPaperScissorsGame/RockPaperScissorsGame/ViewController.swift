//
//  ViewController.swift
//  RockPaperScissorsGame
//
//  Created by Yash Jagtap 2024 on 1/19/23.
//

import UIKit


class ViewController: UIViewController  {
    let url = URL(string: "https://wrpsa.com/the-official-rules-of-rock-paper-scissors/")
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openInSafari(_ sender: UIButton) {

        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
    }
    
}

