//
//  GetSuperHeroes.swift
//  KataSuperHeroes
//
//  Created by Antonio Calvo on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation

class GetSuperHeroes {
    
    fileprivate let repository: SuperHeroesRepository
    
    init(repository: SuperHeroesRepository) {
        self.repository = repository
    }
    
    func execute(_ completion: @escaping ([SuperHero]) -> ()) {
        repository.getAll() { superHeroes in
            completion(superHeroes)
        }
    }
}
