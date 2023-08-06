//
//  PinkViewController.swift
//  SegueActivityA
//
//  Created by Jodi Scott on 10/23/22.
//

import UIKit

class PinkViewController: UIViewController
{

   
    
    var pAnswer: String = ""
    var word = ""
    
    @IBOutlet weak var answerLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    @IBAction func doTheThing(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Type BE", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        {
            textfield in
            textfield.placeholder = "Enter BE"
        }
        
        let ok = UIAlertAction(title: "OK", style: .default){(action) in
            if let letters = alert.textFields?[0].text
            {
                if letters == "BE" {
                    if self.pAnswer != "MAPICEBE" {
                        self.pAnswer=self.pAnswer+letters
                        self.answerLabel.text = self.pAnswer
                    }
                }
            }
            
        }
        
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pinkToFinal"
        {
            var fvc = segue.destination as! LastViewController
            fvc.fAnswer=pAnswer
        }
    }
    
}
