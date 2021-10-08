//
//  MainMapModel.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import MapKit

final class MainMapModel {
    
    func searchBars(in coordinates: CLLocation, completion: @escaping (Result<MKLocalSearch.Response?, Error>) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Bar"
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: coordinates.coordinate, span: span)
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: { (response, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(response))
            }
        })
    }
    
}
