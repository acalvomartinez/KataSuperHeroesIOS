//
//  SuperHeroDetailViewControllerTests.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 13/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import KIF
import Nimble
import UIKit
@testable import KataSuperHeroes

class SuperHeroDetailViewControllerTests: AcceptanceTestCase {
    
    fileprivate let repository = MockSuperHeroesRepository()
    
    func testShowsSuperHeroNamesAsTitle() {
        let superHero = givenASuperHeroWithName()
        
        openSuperHeroDetailViewController(superHeroName: superHero.name)
        
        tester().waitForView(withAccessibilityLabel: superHero.name)
    }
    
    func testShowsSuperHeroInfo() {
        let superHero = givenASuperHeroWithName()
        
        openSuperHeroDetailViewController(superHeroName: superHero.name)
        
        assertSuperHeroExpectedValues(name: superHero.name)
    }
    
    func testShowsSuperHeroBadgeIfSuperHeroIsAnAvenger() {
        let superHero = givenASuperHeroWithName(isAvenger: true)
        
        openSuperHeroDetailViewController(superHeroName: superHero.name)
        
        tester().waitForView(withAccessibilityLabel: "Avenger Badge")
    }
    
    func testShowsNoneSuperHeroBadgeIfSuperHeroIsNOtAnAvenger() {
        let superHero = givenASuperHeroWithName(isAvenger: false)
        
        openSuperHeroDetailViewController(superHeroName: superHero.name)
        
        tester().waitForAbsenceOfView(withAccessibilityLabel: "Avenger Badge")
    }
    
    // MARK: - Helpers
    
    fileprivate func assertSuperHeroExpectedValues(name: String) {
        tester().waitForView(withAccessibilityLabel: "Name: \(name)")
        tester().waitForView(withAccessibilityLabel: "Description: \(name)")
    }
    
    fileprivate func givenASuperHeroWithName(isAvenger: Bool = false) -> SuperHero {
        let superHero = SuperHero(name: "Mr. Clean",
                                  photo: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg"),
                                  isAvenger: isAvenger, description: "Description")
        repository.superHeroes = [superHero]
        return superHero 
    }
    
    fileprivate func openSuperHeroDetailViewController(superHeroName: String) {
        let superHeroDetailViewController = ServiceLocator()
            .provideSuperHeroDetailViewController(superHeroName) as! SuperHeroDetailViewController
        superHeroDetailViewController.presenter = SuperHeroDetailPresenter(ui: superHeroDetailViewController,
                                                                           superHeroName: superHeroName,
                                                                           getSuperHeroByName: GetSuperHeroByName(repository: repository))
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroDetailViewController]
        present(viewController: rootViewController)
        tester().waitForAnimationsToFinish()
    }
}
