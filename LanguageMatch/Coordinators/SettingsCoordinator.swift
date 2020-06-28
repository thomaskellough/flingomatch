//
//  SettingsCoordinator.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 6/27/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import  UIKit


class SettingsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    var children: [Coordinator] = []
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with delegate: ViewController?) {
        let vc = SettingsViewController.instantiate()
        vc.coordinator = self
        vc.delegate = delegate
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAcknowledgements() {
        let vc = AcknowledgementsViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didLeaveSettings() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
