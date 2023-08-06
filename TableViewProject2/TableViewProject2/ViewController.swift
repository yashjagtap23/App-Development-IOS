//
//  ViewController.swift
//  TableViewProject2
//
//  Created by Yash Jagtap 2024 on 3/13/23.
//



var data = [MovieData(sectionType: "Movies", Movies:
                     ["drstrange", "ironman", "spiderman"], rating: [91,89,79]),
            MovieData(sectionType: "Movies2", Movies:
                                 ["avatar", "blackpanther", "titanic"], rating: [91,99,79]),
                      MovieData(sectionType: "Movies3", Movies:
                                           ["manhattan", "starwars", "harrypotter"], rating: [100,89,80])

]


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].sectionType
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.collectionView.tag = indexPath.section
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .red
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[collectionView.tag].Movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: data[collectionView.tag].Movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = UIImage(named: data[collectionView.tag].Movies[indexPath.row])
        let ratingOfM = data[collectionView.tag].rating[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let DetailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            DetailsViewController.ratingM = ratingOfM
            DetailsViewController.imageTouched = selectedImage
            self.navigationController?.pushViewController(DetailsViewController, animated: true)
        }
    }

}

