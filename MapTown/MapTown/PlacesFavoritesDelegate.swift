//
//  PlacesFavoritesDelegate.swift
//  MapTown
//
//  Created by 周越 on 2/13/22.
//

import Foundation
import UIKit

protocol PlacesFavoritesDelegate: class {
    
    func favoritePlace(name: String) -> Void
    
}
