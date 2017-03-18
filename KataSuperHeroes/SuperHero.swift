//
//  SuperHero.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation

struct SuperHero {
    
    let id: String
    let name: String
    let photo: URL?
    let isAvenger: Bool
    let description: String

    func withIsAvenger(isAvenger: Bool) -> SuperHero {
        return SuperHero(id: id,
                         name: name,
                         photo: photo,
                         isAvenger: isAvenger,
                         description: description)
    }
}
