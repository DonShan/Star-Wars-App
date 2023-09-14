//
//  PlanetDetailViewController.swift
//  Star Wars App
//
//  Created by Madushan Senavirathna on 2023-09-14.
//

import UIKit
import RxSwift

class PlanetDetailViewController: UIViewController {
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var orbitalPeriodLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var iconPlanet: UIImageView!
    
    var planet: Planet?
    private let disposeBag = DisposeBag()
    
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
            URLSession.shared.rx.data(request: URLRequest(url: imageURL))
                .map { data -> UIImage? in
                    return UIImage(data: data)
                }
                .observeOn(MainScheduler.instance)
                .bind(to: iconPlanet.rx.image)
                .disposed(by: disposeBag)
        }
    }
}


