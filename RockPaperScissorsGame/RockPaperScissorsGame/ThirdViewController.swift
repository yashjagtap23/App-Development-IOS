//
//  ThirdViewController.swift
//  RockPaperScissorsGame
//
//  Created by Yash Jagtap 2024 on 1/20/23.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var cpuImage: UIImageView!
    var choice: Int = 0
    var cpuChoice: Int = Int.random(in: 0..<3)
    let image = UIImage(named: "rock")
    let image2 = UIImage(named: "paper")
    let image3 = UIImage(named: "scissors")
    
    override func viewDidLoad() {
        print(choice)
        super.viewDidLoad()
        if(choice == 0)
        {
            playerImage.image = UIImage(named: "rock")
        }
        else if(choice == 1)
        {
            
            playerImage.image = UIImage(named: "paper")
        }
        else
        {
            
            playerImage.image = UIImage(named: "scissors")
        }
        
        if(cpuChoice == 0)
        {
            cpuImage.image = UIImage(named: "rock")
        }
        else if(cpuChoice == 1)
        {
            
            cpuImage.image = UIImage(named: "paper")
        }
        else
        {
            
            cpuImage.image = UIImage(named: "scissors")
        }
        whoWon()

    }
    
    func whoWon()
    {
        if(choice == cpuChoice)
        {
            let alert = UIAlertController(title: "Tie", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default)
            {
                (action) in
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else if(choice == 0 && cpuChoice == 1)
        {
            let alert = UIAlertController(title: "CPU Wins", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default)
            {
                (action) in
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else if(choice == 0 && cpuChoice == 2)
        {
            let alert = UIAlertController(title: "Player Wins", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default)
            {
                (action) in
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else if(choice == 1 && cpuChoice == 0)
        {
            let alert = UIAlertController(title: "Player Wins", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default)
            {
                (action) in
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else if(choice == 1 && cpuChoice == 2)
        {
            let alert = UIAlertController(title: "CPU Wins", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default)
            {
                (action) in
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else if(choice == 2 && cpuChoice == 1)
        {
            let alert = UIAlertController(title: "Player Wins", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default)
            {
                (action) in
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "CPU Wins", message: nil, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default)
            {
                (action) in
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        
    }
    }
