//
//  Planet.swift
//  Star Wars App
//
//  Created by Madushan Senavirathna on 2023-09-14.
//

import Foundation

struct Planet: Codable {
    let name: String
    let climate: String
    let orbitalPeriod: String?
    let gravity: String
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case climate
        case orbitalPeriod = "orbital_period"
        case gravity
        case imageURL = "image_url"
    }
}

struct PlanetResponse: Decodable {
    let results: [Planet]
}
