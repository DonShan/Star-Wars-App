//
//  PlanetsViewController.swift
//  Star Wars App
//
//  Created by Madushan Senavirathna on 2023-09-14.
//

import UIKit
import RxSwift
import RxCocoa

class PlanetsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = PlanetsViewModel()
    
    private var planets: [Planet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPlanets()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Star Wars App"
    }
    
    func fetchPlanets() {
        viewModel.fetchPlanets()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] planets in
                self?.planets = planets
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
}

extension PlanetsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath) as! PlanetTableViewCell
        let planet = planets[indexPath.row]
        cell.planetName?.text = "Planet Name: \(planet.name)"
        cell.climate?.text = "Climate: \(planet.climate)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let planet = planets[indexPath.row]
        
        if let planetDetailVC = storyboard?.instantiateViewController(withIdentifier: "PlanetDetailViewController") as? PlanetDetailViewController {
            planetDetailVC.planet = planet
            navigationController?.pushViewController(planetDetailVC, animated: true)
        }
    }
    
}
