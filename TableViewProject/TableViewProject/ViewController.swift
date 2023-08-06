//
//  ViewController.swift
//  TableViewProject
//
//  Created by Yash Jagtap 2024 on 3/8/23.
//

import UIKit

class ViewController: UIViewController {

    struct Album
    {
        var title: String
        var imageName: String
    }
    
    @IBOutlet weak var table: UITableView!
    
    var data: [Album] = [
        Album(title: "Rose", imageName: "rose"),
        Flower(title: "Lily", imageName: "lily"),
        Flower(title: "Tulip", imageName: "tulip"),
        Flower(title: "Orchid", imageName: "orchid")
        ]
    
   var names: [String] = ["Rose","Lily","Tulip","Orchid"]
    var pictures: [String] = ["rose","lily","tulip","orchid"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
}
extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let location = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.picturesView.image = UIImage(named: location.imageName)
        cell.nameLabel.text = location.title
        return cell
    }

}
extension ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}





