//
//  SuperHeroesRepository.swift
//  KataSuperHeroes
//
//  Created by Antonio Calvo on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import MarvelAPIClient
import Result

enum SuperHeroesError: Error {
    case networkError
    case invalidSession
}

class SuperHeroesRepository {
    init() {
        MarvelAPIClient.configureCredentials(
            publicKey: "bf1f5d5f088f59478a3f68324fd1face",
            privateKey: "d3fa0b1bad53d48b8bac7b9d4a02a860d24caca0")
    }
    
    func getAll(_ completion: @escaping (Result<[SuperHero], SuperHeroesError>) -> ()) {
        let charactersAPIClient = MarvelAPIClient.charactersAPIClient
        
        charactersAPIClient.getAll(offset: 0, limit: 50) { response in
            if let error = response.error {
                switch error {
                case .networkError:
                    completion(Result(error: .networkError))
                default:
                    completion(Result(error: .invalidSession))
                }
                return
            }
            
            let characters = response.value?.characters?.map {
                SuperHero(id: $0.id,
                          name: $0.name ?? "",
                          photo: $0.thumbnail?.URL(variant: .portraitUncanny) as URL?,
                          isAvenger: false,
                          description: $0.description ?? "")
            }
            completion(Result(value: characters!))
        }
    }
    
    func getDetail(id: String, _ completion: @escaping (SuperHero) -> ()) {
        let charactersAPIClient = MarvelAPIClient.charactersAPIClient
        
        charactersAPIClient.getById(id: id) { (result) in
            let character = result.value.map {
                SuperHero(id: $0.id,
                          name: $0.name ?? "",
                          photo: $0.thumbnail?.URL(variant: .portraitUncanny) as URL?,
                          isAvenger: false,
                          description: $0.description ?? "")
            }
           completion(character!)
        }
    }
    
}
