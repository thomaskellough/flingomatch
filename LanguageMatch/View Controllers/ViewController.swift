//
//  ViewController.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/2/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?

    static var defaultLanguageKey = "language"
    static var currentLanguage: Language!
    static var hardMode: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Setup
    override func loadView() {
        let defaults = UserDefaults.standard
        let defaultLanguage = defaults.object(forKey: ViewController.defaultLanguageKey) as? String ?? "French"
        ViewController.currentLanguage = Language(name: defaultLanguage)
        ViewController.updateCurrentLanguage(language: ViewController.currentLanguage.name)
        ViewController.updateHardMode()
        view = MainView(ViewController.currentLanguage,
                        chooseLanguageAction: selectLanguage,
                        timedPlayAction: timedPlay,
                        singlePlayerAction: singlePlay,
                        twoPlayerAction: twoPlay,
                        studyAction: study,
                        settingsAction: settings)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadView()
        title = "Flingo Match - \(ViewController.currentLanguage.name)"
    }
    
    // MARK: Updates
    static func updateHardMode() {
        let defaults = UserDefaults.standard
        ViewController.hardMode = defaults.bool(forKey: "switchState")
    }
    
    static func updateCurrentLanguage(language: String) {
        ViewController.currentLanguage = Language(name: language)
    }
        
    // MARK: Navigation
    @objc func selectLanguage() {
        coordinator?.showSelectLanguage()
    }
    
    @objc func timedPlay() {
        let gameType = "timed"
        coordinator?.showGameController(for: gameType)
    }
    
    @objc func singlePlay() {
        let gameType = "single"
        coordinator?.showGameController(for: gameType)
    }
    
    @objc func twoPlay() {
        let gameType = "two"
        coordinator?.showGameController(for: gameType)
    }
    
    @objc func study() {
        // Would like to add functionality for smaller devices. Need to make collection view cells non-static sizes
        if UIScreen.main.bounds.size.width < 375 {
            let ac = UIAlertController(title: "Error", message: "This device does not support this functionality.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        } else {
            coordinator?.showStudyWords()
        }
    }
    
    @objc func settings() {
        coordinator?.showSettings()
    }
}
