//
//  PlanetsViewModel.swift
//  Star Wars App
//
//  Created by Madushan Senavirathna on 2023-09-14.
//

import Foundation
import RxSwift

class PlanetsViewModel {
    private let service = StarWarsService.shared
    
    func fetchPlanets() -> Observable<[Planet]> {
        return service.fetchPlanets()
    }
}
