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
        
        setupTableViewBindings()
        navigationItem.title = "Star Wars App"
    }
    
    func setupTableViewBindings() {
        let planetsObservable = viewModel.fetchPlanets()
            .observe(on: MainScheduler.instance)
            .share()
        
        planetsObservable
            .bind(to: tableView.rx.items(cellIdentifier: "PlanetCell", cellType: PlanetTableViewCell.self)) { _, planet, cell in
                cell.planetName?.text = "Planet Name: \(planet.name)"
                cell.climate?.text = "Climate: \(planet.climate)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
                let planet = self?.planets[indexPath.row]
                self?.navigateToPlanetDetail(planet)
            })
            .disposed(by: disposeBag)
        
        planetsObservable
            .subscribe(onNext: { [weak self] planets in
                self?.planets = planets
            })
            .disposed(by: disposeBag)
    }
    
    func navigateToPlanetDetail(_ planet: Planet?) {
        guard let planet = planet else { return }
        
        if let planetDetailVC = storyboard?.instantiateViewController(withIdentifier: "PlanetDetailViewController") as? PlanetDetailViewController {
            planetDetailVC.planet = planet
            navigationController?.pushViewController(planetDetailVC, animated: true)
        }
    }
}
