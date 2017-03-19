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
        let richModel = SuperHeroesRichModel(repository: SuperHeroesRepository())
        let presenter = SuperHeroesPresenter(ui: superHeroesViewController,
                                             getSuperHeroes: GetSuperHeroes(richModel: richModel))
        
        let dataSource = provideSuperHeroesDataSource()
        superHeroesViewController.presenter = presenter
        superHeroesViewController.dataSource = dataSource
        superHeroesViewController.delegate =
            BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        return superHeroesViewController
    }

    func provideSuperHeroDetailViewController(_ superHeroId: String, isAvenger: Bool) -> UIViewController {
        let viewController: SuperHeroDetailViewController =
        storyBoard.instantiateViewController("SuperHeroDetailViewController")
        let richModel = SuperHeroesRichModel(repository: SuperHeroesRepository())
        let presenter = SuperHeroDetailPresenter(superHeroId: superHeroId, ui: viewController, isAvenger: isAvenger, getSuperHeroDetail: GetSuperHeroDetail(richModel: richModel))
        viewController.presenter = presenter
        return viewController
    }

    fileprivate func provideSuperHeroesDataSource() -> BothamTableViewDataSource<SuperHero, SuperHeroTableViewCell> {
        return BothamTableViewDataSource<SuperHero, SuperHeroTableViewCell>()
    }

    fileprivate lazy var storyBoard: BothamStoryboard = {
        return BothamStoryboard(name: "SuperHeroes")
    }()

}
