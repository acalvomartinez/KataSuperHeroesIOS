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
        getSuperHeroes.execute { result in
            DispatchQueue.main.async {
                if let error = result.error {
                    self.ui?.showError(error)
                    return
                }
                
                let superHeroes = result.value!
                
                if superHeroes.count > 0 {
                    self.ui?.show(items: superHeroes)
                } else {
                    self.ui?.showEmptyCase()
                }
            }
        }
    }

    func itemWasTapped(_ item: SuperHero) {
        let superHeroDetailViewController = ServiceLocator().provideSuperHeroDetailViewController(item.id)
        
        self.ui?.openSuperHeroDetailScreen(superHeroDetailViewController)
    }
}
