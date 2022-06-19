//
//  MapViewController.swift
//  MapTown
//
//  Created by 周越 on 2/12/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    var Placeselected : Place = Place()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        detailView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        detailButton.setImage(UIImage(systemName: "star"), for: .normal)
        
        let places = DataManager.places
        for place in places {
            mapView.addAnnotation(place) //create and add anation, find the Wrigley Field and select it
            if place.name == "Wrigley Field" {
                mapView.selectAnnotation(place, animated: true)
            }
        }


        detailButton.addTarget(self, action: #selector(self.tapToAddFavorite(sender:)), for: UIControl.Event.touchUpInside)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let miles: Double = 20 * 1000
        let centerPoint = CLLocationCoordinate2DMake(41.8780, -87.6299)
        let viewRegion = MKCoordinateRegion(center: centerPoint, latitudinalMeters: miles, longitudinalMeters: miles)
        mapView.setRegion(viewRegion, animated: true)
        
    }
    @objc func tapToAddFavorite(sender: UIButton!){
        let favoritePlaces = DataManager.sharedInstance.listFavorites()
        if favoritePlaces.contains(Placeselected.name!) {
            DataManager.sharedInstance.deleteFavorite(place: Placeselected)
            sender.isSelected = false
            detailButton.setImage(UIImage(systemName: "star"), for: .normal)
        }else {
            DataManager.sharedInstance.saveFavorites(place: Placeselected)
            sender.isSelected = true
            detailButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }

    @IBAction func tapFavorite(_ sender: UIButton) {
        let favoritesViewController = self.storyboard?.instantiateViewController(identifier: "FavoritesViewController") as! FavoritesViewController
        if let sheet = favoritesViewController.sheetPresentationController{
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        present(favoritesViewController ,animated: true, completion: nil)
        favoritesViewController.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        let place = view.annotation as! Place
        let favPlaces = DataManager.sharedInstance.listFavorites()
        // update the Place, make sure the information match the info view
        self.Placeselected = place
        detailTitle.text = place.name
        detailDescription.text = place.longDescription
        if favPlaces.contains(Placeselected.name!) {
            detailButton.isSelected = true
            detailButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else {
            detailButton.isSelected = false
            detailButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
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


extension MapViewController: PlacesFavoritesDelegate {
    func favoritePlace(name: String) {
//        print(name)
        if let place = DataManager.sharedInstance.getPlaceByName(name: name) {
            let miles : Double = 20 * 300 // region span
            let region = MKCoordinateRegion.init(center: place.coordinate, latitudinalMeters: miles, longitudinalMeters: miles)
            mapView.setRegion(region, animated: true)
//            print("2")
            let favPlaces = DataManager.sharedInstance.listFavorites()
            // update the Place, make sure the information match the info view
            self.Placeselected = place
            detailTitle.text = place.name
            detailDescription.text = place.longDescription
            if favPlaces.contains(Placeselected.name!) {
                detailButton.isSelected = true
                detailButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }else {
                detailButton.isSelected = false
                detailButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
}

