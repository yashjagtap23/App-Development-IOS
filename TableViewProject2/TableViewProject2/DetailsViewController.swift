//
//  DetailsViewController.swift
//  TableViewProject2
//
//  Created by Yash Jagtap 2024 on 3/20/23.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    var imageTouched: UIImage?
    var ratingM: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingLabel.text = "Audiences Rate This Movie: \(ratingM ?? 0)%"
        if let imageTouched = imageTouched
        {
            imageView.image = imageTouched
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
