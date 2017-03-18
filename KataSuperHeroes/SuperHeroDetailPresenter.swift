//
//  SuperHeroDetailPresenter.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 09/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation

import BothamUI

class SuperHeroDetailPresenter: BothamPresenter {
    fileprivate let superHeroId: String
    fileprivate let getSuperHeroDetail: GetSuperHeroDetail
    fileprivate weak var ui: SuperHeroUI?
    
    init(superHeroId: String, ui: SuperHeroUI, getSuperHeroDetail: GetSuperHeroDetail) {
        self.superHeroId = superHeroId
        self.ui = ui
        self.getSuperHeroDetail = getSuperHeroDetail
    }
    
    func viewDidLoad() {
        getSuperHeroDetail.execute(id: superHeroId) { (superHero) in
            DispatchQueue.main.async {
                self.ui?.show(superHero: superHero)
            }
        }
    }

}
