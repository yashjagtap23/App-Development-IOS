//
//  LastViewController.swift
//  SegueActivityA
//
//  Created by Jodi Scott on 10/23/22.
//

import UIKit

class LastViewController: UIViewController
{

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    
    var fAnswer: String = ""
    var lastLetters = "CL"
    @IBOutlet weak var answerTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        answerLabel.text = fAnswer + lastLetters
        
    }
    
    @IBAction func inputTriggered(_ sender: UITextField) {
        if answerTextField.text! == "IMPECCABLE" {
            winLabel.isHidden=false
        }
    }
    
}
