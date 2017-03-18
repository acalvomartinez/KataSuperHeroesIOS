//
//  RootWireframe.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI

class ServiceLocator {

    func provideRootViewController() -> UIViewController {
        let navigationController: UINavigationController = storyBoard.initialViewController()
        navigationController.viewControllers = [provideSuperHeroesViewController()]
        return navigationController
    }

    func provideSuperHeroesViewController() -> UIViewController {
        let superHeroesViewController: SuperHeroesViewController =
        storyBoard.instantiateViewController("SuperHeroesViewController")
        let repository = SuperHeroesRepository()
        let presenter = SuperHeroesPresenter(ui: superHeroesViewController,getSuperHeroes: GetSuperHeroes(repository: repository))
        
        let dataSource = provideSuperHeroesDataSource()
        superHeroesViewController.presenter = presenter
        superHeroesViewController.dataSource = dataSource
        superHeroesViewController.delegate =
            BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return superHeroesViewController
    }

    func provideSuperHeroDetailViewController(_ superHeroName: String) -> UIViewController {
        let viewController: SuperHeroDetailViewController =
        storyBoard.instantiateViewController("SuperHeroDetailViewController")
        viewController.presenter = SuperHeroDetailPresenter()
        return viewController
    }

    fileprivate func provideSuperHeroesDataSource() -> BothamTableViewDataSource<SuperHero, SuperHeroTableViewCell> {
        return BothamTableViewDataSource<SuperHero, SuperHeroTableViewCell>()
    }

    fileprivate lazy var storyBoard: BothamStoryboard = {
        return BothamStoryboard(name: "SuperHeroes")
    }()

}
