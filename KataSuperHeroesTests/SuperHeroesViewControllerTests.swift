//
//  SuperHeroesViewControllerTests.swift
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

class SuperHeroesViewControllerTests: AcceptanceTestCase {

    fileprivate let repository = MockSuperHeroesRepository()
    
    fileprivate let emptyCaseText = "¯\\_(ツ)_/¯"

    func testShowsEmptyCaseIfThereAreNoSuperHeroes() {
        givenThereAreNoSuperHeroes()

        openSuperHeroesViewController()

        tester().waitForView(withAccessibilityLabel: emptyCaseText)
    }
    
    func testNotShowsEmptyCaseItThereAreSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes(1)
        
        openSuperHeroesViewController()
        
        tester().waitForAbsenceOfView(withAccessibilityLabel: emptyCaseText)
    }
    
    func testShowsSuperHeroNameIfThereIsASuperHero() {
        let superHeroes = givenThereAreSomeSuperHeroes(1)
        
        openSuperHeroesViewController()
        
        tester().waitForView(withAccessibilityLabel: superHeroes[0].name)
    }
    
    func testShowsSomeSuperHeroesNamesIfThereAreSomeSuperHeroes() {
        let superHeroes = givenThereAreSomeSuperHeroes(5)
        
        openSuperHeroesViewController()
        
        for i in 0..<superHeroes.count {
            tester().waitForView(withAccessibilityLabel: superHeroes[i].name)
        }
    }
    
    func testShowsNoneBadgesIfAllSuperHeroesAreNotAvengers() {
        let superHeroes = givenThereAreSomeSuperHeroes(5, avengers: false)
        
        openSuperHeroesViewController()
        
        for i in 0..<superHeroes.count {
            _ = tester().waitForAbsenceOfView(withAccessibilityLabel: "\(superHeroes[i].name) - Avengers Badge")
        }
    }
    
    func testShowsBadgesIfAllSuperHeroesAreAvengers() {
        let superHeroes = givenThereAreSomeSuperHeroes(5, avengers: true)
        
        openSuperHeroesViewController()
        
        for i in 0..<superHeroes.count {
            _ = tester().waitForView(withAccessibilityLabel: "\(superHeroes[i].name) - Avengers Badge")
        }
    }
    
    func testOpenDetailWhenTapOnAnyRow() {
        let superHeroes = givenThereAreSomeSuperHeroes(5, avengers: true)
        
        openSuperHeroesViewController()
        
        tester().waitForView(withAccessibilityLabel: superHeroes[1].name)
        tester().tapRow(at: IndexPath.init(row: 1, section: 0), inTableViewWithAccessibilityIdentifier: "SuperHeroesTableView")
        // test uilabel navigation bar
        tester().waitForView(withAccessibilityLabel: superHeroes[1].name)
    }
    
    // MARK: - Helpers

    fileprivate func givenThereAreNoSuperHeroes() {
        _ = givenThereAreSomeSuperHeroes(0)
    }

    fileprivate func givenThereAreSomeSuperHeroes(_ numberOfSuperHeroes: Int = 10,
        avengers: Bool = false) -> [SuperHero] {
        var superHeroes = [SuperHero]()
        for i in 0..<numberOfSuperHeroes {
            let superHero = SuperHero(name: "SuperHero - \(i)",
                photo: NSURL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg") as URL?,
                isAvenger: avengers, description: "Description - \(i)")
            superHeroes.append(superHero)
        }
        repository.superHeroes = superHeroes
        return superHeroes
    }

    fileprivate func openSuperHeroesViewController() {
        let superHeroesViewController = ServiceLocator()
            .provideSuperHeroesViewController() as! SuperHeroesViewController
        superHeroesViewController.presenter = SuperHeroesPresenter(ui: superHeroesViewController,
                getSuperHeroes: GetSuperHeroes(repository: repository))
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroesViewController]
        present(viewController: rootViewController)
        tester().waitForAnimationsToFinish()
    }
}
