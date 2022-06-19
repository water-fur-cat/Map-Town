//
//  FavoritesViewController.swift
//  MapTown
//
//  Created by 周越 on 2/13/22.
//

import UIKit
import MapKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.favoritePlace(name: DataManager.sharedInstance.listFavorites()[indexPath.row])
//        print("1")
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.listFavorites().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = DataManager.sharedInstance.listFavorites()[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var favoriteTable: UITableView!
    
    weak var delegate: PlacesFavoritesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.addTarget(self,action: #selector(self.tapButton(sender:)),
                             for: UIControl.Event.touchUpInside)
        favoriteTable.delegate = self
        favoriteTable.dataSource = self
//        self.view.addSubview(favoriteTable)
        
        // Do any additional setup after loading the view.
    }
    @objc func tapButton(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
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

