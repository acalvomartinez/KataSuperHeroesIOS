//
//  SuperHeroesRepository.swift
//  KataSuperHeroes
//
//  Created by Antonio Calvo on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import MarvelAPIClient

class SuperHeroesRepository {
    init() {
        MarvelAPIClient.configureCredentials(
            publicKey: "bf1f5d5f088f59478a3f68324fd1face",
            privateKey: "d3fa0b1bad53d48b8bac7b9d4a02a860d24caca0")
    }
    
    func getAll(_ completion: @escaping ([SuperHero]) -> ()) {
        let charactersAPIClient = MarvelAPIClient.charactersAPIClient
        
        charactersAPIClient.getAll(offset: 0, limit: 50) { response in
            let characters = response.value?.characters?.map {
                SuperHero(name: $0.name ?? "",
                          photo: $0.thumbnail?.URL(variant: .landscapeMedium) as URL?,
                          isAvenger: false,
                          description: $0.description ?? "")
            }
            completion(characters!)
        }
        
    }
}
