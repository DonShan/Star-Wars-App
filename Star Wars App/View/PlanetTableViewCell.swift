//
//  PlanetTableViewCell.swift
//  Star Wars App
//
//  Created by Madushan Senavirathna on 2023-09-14.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var climate: UILabel!
    
    func configure(with planet: Planet) {
        planetName.text = "Planet Name: \(planet.name)"
        climate.text = "Climate: \(planet.climate)"
    }
}

