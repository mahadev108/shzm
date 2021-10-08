//
//  PlacesService.swift
//  shazamMapProject
//
//  Created by Shukhrat Sagatov on 08.10.2021.
//

import Foundation

class PlacesService {
    private var storedPaces: [Place] = [
        Place(title: "Mañana", genres: [.glitch, .idm], worktime: "12:00-03:00", distance: "30 м"),
        Place(title: "Bowie", genres: [.ambient], worktime: "10:00-19:00", distance: "4,7 км"),
        Place(title: "Greenside Bar", genres: [.bassHouse], worktime: "12:00-01:00", distance: "5 км")
    ]

    func visitedPlaces() -> [Place] {
        return storedPaces
    }

    func addPlace(_ place: Place) {
        storedPaces.append(place)
    }
}
