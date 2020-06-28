//
//  MainCoordinator.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 6/21/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var navigationController: UINavigationController
    var children = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showSelectLanguage() {
        let vc = LanguageSelectViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showGameController(for typeOfGame: String) {
        let vc = GameViewController.instantiate()
        vc.playMode = typeOfGame
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showStudyWords() {
        let vc = StudyViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSettings() {
        let child = SettingsCoordinator(navigationController: navigationController)
        children.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in children.enumerated() {
            if coordinator === child {
                children.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        guard !navigationController.viewControllers.contains(fromViewController) else { return }
        
        if let buyViewController = fromViewController as? SettingsViewController {
            childDidFinish(buyViewController.coordinator)
        }
    }
    
}
