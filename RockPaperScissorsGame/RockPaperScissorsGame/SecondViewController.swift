//
//  SecondViewController.swift
//  RockPaperScissorsGame
//
//  Created by Yash Jagtap 2024 on 1/20/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var images: [UIImageView]!
    @IBOutlet weak var stackView: UIStackView!
    var userChoice: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func whenTapped(_ sender: UITapGestureRecognizer) {
        let selectedPoint = sender.location(in: stackView)
                for i in images
                {
                    if i.frame.contains(selectedPoint)
                    {
                        userChoice = i.tag
                    }
                }
        
        performSegue(withIdentifier: "segueToNextViewController", sender: userChoice)
         
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! ThirdViewController
               nextViewController.choice = userChoice
    
    }
    }
    

