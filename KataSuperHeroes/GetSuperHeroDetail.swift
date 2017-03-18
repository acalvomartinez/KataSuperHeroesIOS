//
//  GetSuperHeroDetail.swift
//  KataSuperHeroes
//
//  Created by Antonio Calvo on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation

class GetSuperHeroDetail {
    
    fileprivate let repository: SuperHeroesRepository
    
    init(repository: SuperHeroesRepository) {
        self.repository = repository
    }
    
    func execute(id: String, _ completion: @escaping (SuperHero) -> ()) {
        repository.getDetail(id: id) { superHeroe in
            completion(superHeroe)
            
        }
    }
}
