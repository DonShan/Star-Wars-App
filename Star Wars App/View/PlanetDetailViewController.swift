//
//  PlanetDetailViewController.swift
//  Star Wars App
//
//  Created by Madushan Senavirathna on 2023-09-14.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    @IBOutlet weak var planetNameLabel: UILabel! 
    @IBOutlet weak var orbitalPeriodLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var iconPlanet: UIImageView!
    
    var planet: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planetData()
        fetchImage()
    }
    
    func planetData() {
        if let planet = planet {
            planetNameLabel.text = "Planet Name: \(planet.name)"
            orbitalPeriodLabel.text = "Orbital Period: \(planet.orbitalPeriod ??  "orbital_period")"
            gravityLabel.text = "Gravity: \(planet.gravity)"
            
        }
    }
    
    func fetchImage() {
        if let imageURLString = planet?.imageURL, let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.iconPlanet.image = image
                    }
                }
            }.resume()
        }
    }
}

