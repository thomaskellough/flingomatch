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

class ViewController: UIViewController {
    
    var currentLanguageBtn: UIButton!
    var timedPlayBtn: UIButton!
    var singlePlayerBtn: UIButton!
    var twoPlayerBtn: UIButton!
    var studyBtn: UIButton!
    var settingsBtn: UIButton!
    var currentLanguage: Language!
    var hardMode: Bool?
    var currentDevice: String!
    var flagSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let defaultLanguage = defaults.object(forKey: "language") as? String ?? "French"
        currentLanguage = Language(name: defaultLanguage)
        updateCurrentLanguage(language: currentLanguage.name)
        updateHardMode()
        
        performSelector(onMainThread: #selector(loadInterface), with: nil, waitUntilDone: false)
        
    }
    
    func updateHardMode() {
        let defaults = UserDefaults.standard
        hardMode = defaults.bool(forKey: "switchState")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        performSelector(onMainThread: #selector(updateLanguage), with: nil, waitUntilDone: false)
    }
    
    @objc func updateLanguage() {
        view.backgroundColor = currentLanguage.colorSecondary
    
        let image = currentLanguage.flag
        
        currentLanguageBtn.backgroundColor = currentLanguage.colorPrimary
        currentLanguageBtn.imageView?.contentMode = .scaleAspectFit
        
        currentLanguageBtn.setImage(image, for: .normal)
        currentLanguageBtn.setTitle("  " + currentLanguage.name, for: .normal)
        currentLanguageBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        currentLanguageBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        
        timedPlayBtn.backgroundColor = currentLanguage.colorPrimary
        timedPlayBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        timedPlayBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        
        singlePlayerBtn.backgroundColor = currentLanguage.colorPrimary
        singlePlayerBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        singlePlayerBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        
        twoPlayerBtn.backgroundColor = currentLanguage.colorPrimary
        twoPlayerBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        twoPlayerBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        
        studyBtn.backgroundColor = currentLanguage.colorPrimary
        studyBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        studyBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        
        settingsBtn.backgroundColor = currentLanguage.colorPrimary
        settingsBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        settingsBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
    }
    
    func updateCurrentLanguage(language: String) {
        currentLanguage = Language(name: language)
    }
    
    @objc func loadInterface() {
        view.backgroundColor = currentLanguage.colorPrimary
        
        let height = view.bounds.size.height / 8
        let width = view.bounds.width - 20
        var gap = CGFloat(10)
        
        let image = currentLanguage.flag
        
        currentLanguageBtn = UIButton(frame: CGRect(x: 0, y: height + gap, width: width, height: height))
        currentLanguageBtn.addTarget(self, action: #selector(selectLanguage), for: .touchUpInside)
        currentLanguageBtn.backgroundColor = currentLanguage.colorPrimary
        currentLanguageBtn.center.x = view.center.x
        currentLanguageBtn.contentHorizontalAlignment = .left
        currentLanguageBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        currentLanguageBtn.imageView?.layer.borderWidth = 2
        currentLanguageBtn.layer.cornerRadius = 10
        currentLanguageBtn.layer.shadowColor = UIColor.black.cgColor
        currentLanguageBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        currentLanguageBtn.layer.shadowOpacity = 0.8
        currentLanguageBtn.setImage(image, for: .normal)
        currentLanguageBtn.setTitle("  " + currentLanguage.name, for: .normal)
        currentLanguageBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        currentLanguageBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        currentLanguageBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        currentLanguageBtn.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        currentLanguageBtn.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        currentLanguageBtn.titleLabel?.layer.shadowOpacity = 0.8
        currentLanguageBtn.titleLabel?.layer.shadowRadius = 5
        view.addSubview(currentLanguageBtn)
        gap += CGFloat(10)
        
        timedPlayBtn = UIButton(frame: CGRect(x: 0, y: 2 * height + gap, width: width, height: height))
        timedPlayBtn.addTarget(self, action: #selector(timedPlayTapped), for: .touchUpInside)
        timedPlayBtn.backgroundColor = currentLanguage.colorPrimary
        timedPlayBtn.center.x = view.center.x
        timedPlayBtn.contentHorizontalAlignment = .left
        timedPlayBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        timedPlayBtn.layer.cornerRadius = 10
        timedPlayBtn.layer.shadowColor = UIColor.black.cgColor
        timedPlayBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        timedPlayBtn.layer.shadowOpacity = 0.8
        timedPlayBtn.layer.shadowRadius = 5
        timedPlayBtn.setTitle("  Timed Play", for: .normal)
        timedPlayBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        timedPlayBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        timedPlayBtn.setImage(UIImage(named: "timed"), for: .normal)
        timedPlayBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        timedPlayBtn.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        timedPlayBtn.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        timedPlayBtn.titleLabel?.layer.shadowOpacity = 0.8
        timedPlayBtn.titleLabel?.layer.shadowRadius = 5
        view.addSubview(timedPlayBtn)
        gap += CGFloat(10)
        
        singlePlayerBtn = UIButton(frame: CGRect(x: 0, y: 3 * height + gap, width: width, height: height))
        singlePlayerBtn.addTarget(self, action: #selector(singlePlayerTapped), for: .touchUpInside)
        singlePlayerBtn.backgroundColor = currentLanguage.colorPrimary
        singlePlayerBtn.center.x = view.center.x
        singlePlayerBtn.contentHorizontalAlignment = .left
        singlePlayerBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        singlePlayerBtn.layer.cornerRadius = 10
        singlePlayerBtn.layer.shadowColor = UIColor.black.cgColor
        singlePlayerBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        singlePlayerBtn.layer.shadowOpacity = 0.8
        singlePlayerBtn.setTitle("  Single Player", for: .normal)
        singlePlayerBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        singlePlayerBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        singlePlayerBtn.setImage(UIImage(named: "onePlayer"), for: .normal)
        singlePlayerBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        singlePlayerBtn.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        singlePlayerBtn.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        singlePlayerBtn.titleLabel?.layer.shadowOpacity = 0.8
        singlePlayerBtn.titleLabel?.layer.shadowRadius = 5
        view.addSubview(singlePlayerBtn)
        gap += CGFloat(10)
        
        twoPlayerBtn = UIButton(frame: CGRect(x: 0, y: 4 * height + gap, width: width, height: height))
        twoPlayerBtn.addTarget(self, action: #selector(twoPlayerTapped), for: .touchUpInside)
        twoPlayerBtn.backgroundColor = currentLanguage.colorPrimary
        twoPlayerBtn.center.x = view.center.x
        twoPlayerBtn.contentHorizontalAlignment = .left
        twoPlayerBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        twoPlayerBtn.layer.cornerRadius = 10
        twoPlayerBtn.layer.shadowColor = UIColor.black.cgColor
        twoPlayerBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        twoPlayerBtn.layer.shadowOpacity = 0.8
        twoPlayerBtn.setTitle("  Two Player", for: .normal)
        twoPlayerBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        twoPlayerBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        twoPlayerBtn.setImage(UIImage(named: "twoPlayer"), for: .normal)
        twoPlayerBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        twoPlayerBtn.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        twoPlayerBtn.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        twoPlayerBtn.titleLabel?.layer.shadowOpacity = 0.8
        twoPlayerBtn.titleLabel?.layer.shadowRadius = 5
        view.addSubview(twoPlayerBtn)
        gap += CGFloat(10)
        
        studyBtn = UIButton(frame: CGRect(x: 0, y: 5 * height + gap, width: width, height: height))
        studyBtn.addTarget(self, action: #selector(studyWordsTapped), for: .touchUpInside)
        studyBtn.backgroundColor = currentLanguage.colorPrimary
        studyBtn.center.x = view.center.x
        studyBtn.contentHorizontalAlignment = .left
        studyBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        studyBtn.layer.cornerRadius = 10
        studyBtn.layer.shadowColor = UIColor.black.cgColor
        studyBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        studyBtn.layer.shadowOpacity = 0.8
        studyBtn.setTitle("  Study Words", for: .normal)
        studyBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        studyBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        studyBtn.setImage(UIImage(named: "study"), for: .normal)
        studyBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        studyBtn.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        studyBtn.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        studyBtn.titleLabel?.layer.shadowOpacity = 0.8
        studyBtn.titleLabel?.layer.shadowRadius = 5
        view.addSubview(studyBtn)
        gap += CGFloat(10)
        
        settingsBtn = UIButton(frame: CGRect(x: 0, y: 6 * height + gap, width: width, height: height))
        settingsBtn.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        settingsBtn.backgroundColor = currentLanguage.colorPrimary
        settingsBtn.center.x = view.center.x
        settingsBtn.contentHorizontalAlignment = .left
        settingsBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        settingsBtn.layer.cornerRadius = 10
        settingsBtn.layer.shadowColor = UIColor.black.cgColor
        settingsBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        settingsBtn.layer.shadowOpacity = 0.8
        settingsBtn.setTitle("  Settings", for: .normal)
        settingsBtn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        settingsBtn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
        settingsBtn.setImage(UIImage(named: "settings"), for: .normal)
        settingsBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        settingsBtn.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        settingsBtn.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        settingsBtn.titleLabel?.layer.shadowOpacity = 0.8
        settingsBtn.titleLabel?.layer.shadowRadius = 5
        view.addSubview(settingsBtn)
    }
    
    @objc func selectLanguage() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "languages") as? LanguageSelectViewController {
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func timedPlayTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "game") as? GameViewController {
            vc.playMode = "timed"
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func singlePlayerTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "game") as? GameViewController {
            vc.playMode = "single"
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func twoPlayerTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "game") as? GameViewController {
            vc.playMode = "two"
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func studyWordsTapped(_ sender: UIButton) {
        // Would like to add functionality for smaller devices. Need to make collection view cells non-static sizes
        if view.bounds.size.width < 375 {
            let ac = UIAlertController(title: "Error", message: "This device does not support this functionality.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "study") as? StudyViewController {
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func settingsTapped() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "settings") as? SettingsViewController {
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

