//
//  GetSuperHeroDetail.swift
//  KataSuperHeroes
//
//  Created by Antonio Calvo on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import Result

class GetSuperHeroDetail {
    
    fileprivate let richModel: SuperHeroesRichModel
    
    init(richModel: SuperHeroesRichModel) {
        self.richModel = richModel
    }
    
    func execute(id: String, isAvenger: Bool, _ completion: @escaping (Result<SuperHero, SuperHeroesError>) -> ()) {
        richModel.getDetail(id: id, isAvenger: isAvenger) { result in
            completion(result)
        }
    }
}
