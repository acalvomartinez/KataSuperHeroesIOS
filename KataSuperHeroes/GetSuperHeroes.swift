//
//  GetSuperHeroes.swift
//  KataSuperHeroes
//
//  Created by Antonio Calvo on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import Result

class GetSuperHeroes {
    
    fileprivate let richModel: SuperHeroesRichModel
    
    init(richModel: SuperHeroesRichModel) {
        self.richModel = richModel
    }
    
    func execute(_ completion: @escaping (Result<[SuperHero], SuperHeroesError>) -> ()) {
        richModel.getAll() { result in
            completion(result)
        }
    }
}
