//
//  ViewController.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/2/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

extension UIView {
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    static var defaultLanguageKey = "language"
    
    static var currentLanguage: Language!
    static var hardMode: Bool?
    var currentLanguageBtn: UIButton!
    var timedPlayBtn: UIButton!
    var singlePlayerBtn: UIButton!
    var twoPlayerBtn: UIButton!
    var studyBtn: UIButton!
    var settingsBtn: UIButton!
    var currentDevice: String!
    var currentScreenWidth: CGFloat!
    var flagSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let defaultLanguage = defaults.object(forKey: ViewController.defaultLanguageKey) as? String ?? "French"
        ViewController.currentLanguage = Language(name: defaultLanguage)
        ViewController.updateCurrentLanguage(language: ViewController.currentLanguage.name)
        ViewController.updateHardMode()
        
        performSelector(onMainThread: #selector(loadInterface), with: nil, waitUntilDone: false)
        
    }
    
    static func updateHardMode() {
        let defaults = UserDefaults.standard
        ViewController.hardMode = defaults.bool(forKey: "switchState")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        performSelector(onMainThread: #selector(updateLanguage), with: nil, waitUntilDone: false)
    }
    
    @objc func updateLanguage() {
        view.backgroundColor = ViewController.currentLanguage.colorSecondary
        title = "Flingo Match - \(ViewController.currentLanguage.name)"
        
        currentLanguageBtn.backgroundColor = ViewController.currentLanguage.colorPrimary
        currentLanguageBtn.setBackgroundImage(ViewController.currentLanguage.flag, for: .normal)
        
        timedPlayBtn.backgroundColor = ViewController.currentLanguage.colorPrimary
        timedPlayBtn.setTitleColor(ViewController.currentLanguage.colorSecondary, for: .normal)
        timedPlayBtn.setTitleColor(ViewController.currentLanguage.colorTertiary, for: .highlighted)
        
        singlePlayerBtn.backgroundColor = ViewController.currentLanguage.colorPrimary
        singlePlayerBtn.setTitleColor(ViewController.currentLanguage.colorSecondary, for: .normal)
        singlePlayerBtn.setTitleColor(ViewController.currentLanguage.colorTertiary, for: .highlighted)
        
        twoPlayerBtn.backgroundColor = ViewController.currentLanguage.colorPrimary
        twoPlayerBtn.setTitleColor(ViewController.currentLanguage.colorSecondary, for: .normal)
        twoPlayerBtn.setTitleColor(ViewController.currentLanguage.colorTertiary, for: .highlighted)
        
        studyBtn.backgroundColor = ViewController.currentLanguage.colorPrimary
        studyBtn.setTitleColor(ViewController.currentLanguage.colorSecondary, for: .normal)
        studyBtn.setTitleColor(ViewController.currentLanguage.colorTertiary, for: .highlighted)
        
        settingsBtn.backgroundColor = ViewController.currentLanguage.colorPrimary
        settingsBtn.setTitleColor(ViewController.currentLanguage.colorSecondary, for: .normal)
        settingsBtn.setTitleColor(ViewController.currentLanguage.colorTertiary, for: .highlighted)
    }
    
    static func updateCurrentLanguage(language: String) {
        ViewController.currentLanguage = Language(name: language)
    }
    
    func styleButton(_ btn: UIButton) {
        btn.center.x = view.center.x
        
        btn.backgroundColor = ViewController.currentLanguage.colorPrimary
        btn.contentHorizontalAlignment = .left
        
        btn.layer.borderColor = ViewController.currentLanguage.colorTertiary?.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.8
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        btn.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        btn.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.titleLabel?.layer.shadowOpacity = 0.8
        btn.titleLabel?.layer.shadowRadius = 5
        
        btn.setTitleColor(ViewController.currentLanguage.colorSecondary, for: .normal)
        btn.setTitleColor(ViewController.currentLanguage.colorTertiary, for: .highlighted)
    }
    
    @objc func loadInterface() {
        view.backgroundColor = ViewController.currentLanguage.colorPrimary
        
        let height = view.bounds.size.height / 8
        let width = view.bounds.width - 20
        var gap = CGFloat(10)
        
        currentLanguageBtn = UIButton(frame: CGRect(x: 0, y: height + gap, width: width, height: height))
        currentLanguageBtn.addTarget(self, action: #selector(selectLanguage), for: .touchUpInside)
        currentLanguageBtn.setBackgroundImage(ViewController.currentLanguage.flag, for: .normal)
        styleButton(currentLanguageBtn)
        view.addSubview(currentLanguageBtn)
        gap += CGFloat(10)
        
        timedPlayBtn = UIButton(frame: CGRect(x: 0, y: 2 * height + gap, width: width, height: height))
        timedPlayBtn.addTarget(self, action: #selector(timedPlayTapped), for: .touchUpInside)
        timedPlayBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        timedPlayBtn.setTitle("  Timed Play", for: .normal)
        timedPlayBtn.setImage(UIImage(named: "timed"), for: .normal)
        styleButton(timedPlayBtn)
        view.addSubview(timedPlayBtn)
        gap += CGFloat(10)
        
        singlePlayerBtn = UIButton(frame: CGRect(x: 0, y: 3 * height + gap, width: width, height: height))
        singlePlayerBtn.addTarget(self, action: #selector(singlePlayerTapped), for: .touchUpInside)
        singlePlayerBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        singlePlayerBtn.setTitle("  Single Player", for: .normal)
        singlePlayerBtn.setImage(UIImage(named: "onePlayer"), for: .normal)
        styleButton(singlePlayerBtn)
        view.addSubview(singlePlayerBtn)
        gap += CGFloat(10)
        
        twoPlayerBtn = UIButton(frame: CGRect(x: 0, y: 4 * height + gap, width: width, height: height))
        twoPlayerBtn.addTarget(self, action: #selector(twoPlayerTapped), for: .touchUpInside)
        twoPlayerBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        twoPlayerBtn.setTitle("  Two Player", for: .normal)
        twoPlayerBtn.setImage(UIImage(named: "twoPlayer"), for: .normal)
        styleButton(twoPlayerBtn)
        view.addSubview(twoPlayerBtn)
        gap += CGFloat(10)
        
        studyBtn = UIButton(frame: CGRect(x: 0, y: 5 * height + gap, width: width, height: height))
        studyBtn.addTarget(self, action: #selector(studyWordsTapped), for: .touchUpInside)
        studyBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        studyBtn.setTitle("  Study Words", for: .normal)
        studyBtn.setImage(UIImage(named: "study"), for: .normal)
        styleButton(studyBtn)
        view.addSubview(studyBtn)
        gap += CGFloat(10)
        
        settingsBtn = UIButton(frame: CGRect(x: 0, y: 6 * height + gap, width: width, height: height))
        settingsBtn.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        settingsBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        settingsBtn.setTitle("  Settings", for: .normal)
        settingsBtn.setImage(UIImage(named: "settings"), for: .normal)
        styleButton(settingsBtn)
        view.addSubview(settingsBtn)
    }
    
    @objc func selectLanguage() {
        coordinator?.showSelectLanguage()
    }
    
    @objc func timedPlayTapped(_ sender: UIButton) {
        let gameType = "timed"
        coordinator?.showGameController(for: gameType)
    }
    
    @objc func singlePlayerTapped(_ sender: UIButton) {
        let gameType = "single"
        coordinator?.showGameController(for: gameType)
    }
    
    @objc func twoPlayerTapped(_ sender: UIButton) {
        let gameType = "two"
        coordinator?.showGameController(for: gameType)
    }
    
    @objc func studyWordsTapped(_ sender: UIButton) {
        // Would like to add functionality for smaller devices. Need to make collection view cells non-static sizes
        if UIScreen.main.bounds.size.width < 375 {
            let ac = UIAlertController(title: "Error", message: "This device does not support this functionality.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        } else {
            coordinator?.showStudyWords()
        }
    }
    
    @objc func settingsTapped() {
        coordinator?.showSettings()
    }
}
