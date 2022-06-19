//
//  PlaceMarkerView.swift
//  MapTown
//
//  Created by 周越 on 2/13/22.
//

import Foundation
import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
      willSet {
        clusteringIdentifier = "Place"
        displayPriority = .defaultLow
        markerTintColor = .systemRed
        glyphImage = UIImage(systemName: "pin.fill")
        }
  }
}
