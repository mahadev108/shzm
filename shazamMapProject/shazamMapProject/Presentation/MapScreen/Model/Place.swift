//
//  Place.swift
//  shazamMapProject
//
//  Created by Shukhrat Sagatov on 08.10.2021.
//

import Foundation
import CoreLocation

struct Place {
    let title: String
    let location: CLLocationCoordinate2D
    let genres: [Genre]
}
