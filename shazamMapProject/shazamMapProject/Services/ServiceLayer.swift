//
//  ServiceLayer.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import Foundation

final class ServiceLayer {
    
    static let shared = ServiceLayer()
    
    private init() {}
    
    static public let locationService = LocationService()
    
}
