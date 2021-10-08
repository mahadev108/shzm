//
//  GenresService.swift
//  shazamMapProject
//
//  Created by Shukhrat Sagatov on 08.10.2021.
//

import Foundation

class GenresService {
    private var storedGenres = Genre.all

    func acquiredGenres() -> [Genre] {
        return storedGenres
    }

    func addGenre(_ genre: Genre) {
        storedGenres.append(genre)
    }
}
