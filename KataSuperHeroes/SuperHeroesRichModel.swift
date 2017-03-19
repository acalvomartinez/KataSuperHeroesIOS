//
//  SuperHeroesRichModel.swift
//  KataSuperHeroes
//
//  Created by Antonio Calvo on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import Result

class SuperHeroesRichModel {
    let repository: SuperHeroesRepository
    
    init(repository: SuperHeroesRepository) {
        self.repository = repository
    }
    
    func getAll(_ completion: @escaping (Result<[SuperHero], SuperHeroesError>) -> ()) {
        repository.getAll { (result) in
            if let error = result.error {
                completion(Result(error: error))
                return
            }
            
            let superHeroes = result.value?.enumerated().map { (index, element) -> SuperHero in
                let isAvenger = (index % 3) == 0
                return element.withIsAvenger(isAvenger: isAvenger)
            }
            
            completion(Result(value: superHeroes!))
        }
    }
    
    func getDetail(id: String, isAvenger: Bool, _ completion: @escaping (Result<SuperHero, SuperHeroesError>) -> ()) {
        repository.getDetail(id: id) { (result) in
            if let error = result.error {
                completion(Result(error: error))
                return
            }
            
            let superHero = result.value.map {
                SuperHero(id: $0.id,
                          name: $0.name,
                          photo: $0.photo,
                          isAvenger: isAvenger,
                          description: $0.description)
            }
            
            completion(Result(value: superHero!))
        }
    }
}
