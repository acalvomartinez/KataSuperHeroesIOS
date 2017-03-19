//
//  SuperHeroesPresenter.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 09/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import BothamUI

class SuperHeroesPresenter: BothamPresenter, BothamNavigationPresenter {
    fileprivate let getSuperHeroes: GetSuperHeroes
    fileprivate weak var ui: SuperHeroesUI?
    
    init(ui: SuperHeroesUI, getSuperHeroes: GetSuperHeroes) {
        self.ui = ui
        self.getSuperHeroes = getSuperHeroes
    }
    
    func viewDidLoad() {
        ui?.showLoader()
        
        getSuperHeroes.execute { result in
            DispatchQueue.main.async {
                self.ui?.hideLoader()
                if let error = result.error {
                    self.ui?.showError(error)
                    return
                }
                
                let superHeroes = result.value!
                
                if superHeroes.isEmpty {
                    self.ui?.showEmptyCase()
                } else {
                    self.ui?.show(items: superHeroes)
                }
            }
        }
    }

    func itemWasTapped(_ item: SuperHero) {
        let superHeroDetailViewController = ServiceLocator().provideSuperHeroDetailViewController(item.id, isAvenger: item.isAvenger)
        
        self.ui?.openSuperHeroDetailScreen(superHeroDetailViewController)
    }
}
