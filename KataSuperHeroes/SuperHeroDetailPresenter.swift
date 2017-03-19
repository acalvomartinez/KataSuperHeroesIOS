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
    fileprivate let isAvenger: Bool
    fileprivate let getSuperHeroDetail: GetSuperHeroDetail
    fileprivate weak var ui: SuperHeroUI?
    
    init(superHeroId: String, ui: SuperHeroUI, isAvenger: Bool, getSuperHeroDetail: GetSuperHeroDetail) {
        self.superHeroId = superHeroId
        self.isAvenger = isAvenger
        self.ui = ui
        self.getSuperHeroDetail = getSuperHeroDetail
    }
    
    func viewDidLoad() {
        ui?.showLoader()
        getSuperHeroDetail.execute(id: superHeroId, isAvenger: isAvenger) { (result) in
            DispatchQueue.main.async {
                self.ui?.hideLoader()
                if let error = result.error {
                    self.ui?.showError(error)
                    return
                }
                
                if let superHero = result.value {
                    self.ui?.title = superHero.name
                    self.ui?.show(superHero: superHero)
                } else {
                    self.ui?.showError(.unknown)
                }
            }
        }
    }

}
