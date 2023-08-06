//
//  BlueViewController.swift
//  SegueActivityA
//
//  Created by Jodi Scott on 10/23/22.
//

import UIKit

class BlueViewController: UIViewController
{

    
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    var bAnswer: String = ""
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        answerLabel.text = bAnswer
        
        
    }
    
    @IBAction func pressToAccept(_ sender: UIButton) {
        if answerTextField.text! == "ICE" {
            if bAnswer != "MAPICE" {
                bAnswer += answerTextField.text!
                answerLabel.text = bAnswer
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "blueToPink"
        {
            var pvc = segue.destination as! PinkViewController
            pvc.pAnswer=bAnswer
        }
    }
    
    
    

    

}
