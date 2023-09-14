//
//  StarWarsService.swift
//  Star Wars App
//
//  Created by Madushan Senavirathna on 2023-09-14.
//

import Foundation
import RxSwift

class StarWarsService {
    static let shared = StarWarsService()
    
    private let baseURL = "https://swapi.dev/api"
    
    func fetchPlanets() -> Observable<[Planet]> {
        return Observable.create { observer in
            guard let url = URL(string: "\(self.baseURL)/planets") else {
                observer.onError(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NSError(domain: "No data received", code: 0, userInfo: nil))
                    return
                }
                
                do {
                    let planetsResponse = try JSONDecoder().decode(PlanetResponse.self, from: data)
                    let planetsWithImages = planetsResponse.results.map { planet -> Planet in
                        let imageURL = "http://picsum.photos/400/200"
                        var planetWithImage = planet
                        planetWithImage.imageURL = imageURL
                        
                        return planetWithImage
                    }
                    
                    observer.onNext(planetsWithImages)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}

