//
//  DataManager.swift
//  MapTown
//
//  Created by 周越 on 2/13/22.
//

import Foundation
import UIKit
import MapKit

public class DataManager {
  
  // MARK: - Singleton Stuff
    public static let sharedInstance = DataManager()
    
    private let defaults = UserDefaults.standard
    static var places : [Place] {
        return sharedInstance.loadAnnotationFromPlist()
    }
  
  //This prevents others from using the default '()' initializer
    fileprivate init() {}

    private func loadAnnotationFromPlist() -> [Place] {
//        if let infoPlistPath = Bundle.main.url(forResource: "Data", withExtension: "plist") {
//            do {
//                let infoPlistData = try Data(contentsOf: infoPlistPath)
//                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
//                    let landmarks = (dict["places"]! as? [[String : Any]])!
//                    for i in 0...landmarks.count-1 {
//                        let place_i = Place(name:landmarks[i]["name"]! as! String, des:landmarks[i]["description"]! as! String,coord:CLLocationCoordinate2D(latitude: landmarks[i]["lat"]! as! CLLocationDegrees,longitude: landmarks[i]["long"]! as! CLLocationDegrees))
//                        mapView.addAnnotation(place_i)
//                    }
//                }
//            } catch {
//                print(error)
//            }
//        }
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if let data = plist["places"] as? [[String : Any]] {
                let places = data.map { item -> Place in
                    let place = Place()
                    place.coordinate = CLLocationCoordinate2DMake(item["lat"]! as! CLLocationDegrees, item["long"] as! CLLocationDegrees)
                    place.name = item["name"] as? String
                    place.longDescription = item["description"] as? String
                    return place
                }
                return places
            }
        }
        return []
    }
    
    func loadRegion() -> MKCoordinateRegion {
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if let data = plist["region"] as? [NSNumber] {
                let coordinate = CLLocationCoordinate2DMake(data[0].doubleValue, data[1].doubleValue)
                let span = MKCoordinateSpan(latitudeDelta: data[2].doubleValue, longitudeDelta: data[3].doubleValue)
                return MKCoordinateRegion.init(center: coordinate, span: span)
            }
        }
        return MKCoordinateRegion.init()
    }
    
    func saveFavorites(place: Place) {
        if let key = place.name {
            defaults.set(place.longDescription, forKey: key)
        }
    }
    func deleteFavorite(place: Place) {
        if let key = place.name {
            defaults.removeObject(forKey: key)
        }
    }
    func listFavorites() -> [String] {
        var Places : [String] = []
        for place in DataManager.places {
            if let key = place.name {
                if defaults.string(forKey: key) != nil {
                    Places.append(place.name!)
                }
            }
        }
        return Places
    }
    
    func getPlaceByName(name : String) -> Place? {
        for place in DataManager.places {
            if place.name == name {
                return place
            }
        }
        return nil
    }
}
