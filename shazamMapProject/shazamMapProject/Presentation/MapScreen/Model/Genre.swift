//
//  Genre.swift
//  shazamMapProject
//
//  Created by Shukhrat Sagatov on 08.10.2021.
//

import Foundation

struct Genre {
    let title: String

    static var glitch = Genre(title: "Glitch")
    static var idm = Genre(title: "IDM")
    static var ambient = Genre(title: "Ambient")
    static var bassHouse = Genre(title: "bass house")

    static var all: [Genre] = [
        glitch,
        idm,
        ambient,
        bassHouse
    ]
}
