//
//  ViewController.swift
//  SegueActivityA
//
//  Created by Jodi Scott on 10/23/22.
//

import UIKit

class YellowViewController: UIViewController
{
    
    @IBOutlet weak var answerLabel: UILabel!
    
    var firstScreen = "MAP"
    var answer: String = ""
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        answerLabel.text = firstScreen
        answer = firstScreen
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "yellowToBlue"
        {
            var bvc = segue.destination as! BlueViewController
            bvc.bAnswer=answer
        }
    }

}

