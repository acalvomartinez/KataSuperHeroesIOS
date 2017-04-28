//
//  SuperHeroesError.swift
//  KataSuperHeroes
//
//  Created by Antonio Calvo on 27/04/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import Result

public enum SuperHeroesError: Error {
    
    case networkError
    case itemNotFound
    case unknownError(code: Int)
    
}
