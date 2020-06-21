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
    var currentScreenWidth: CGFloat!
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
        title = "Flingo Match - \(currentLanguage.name)"
        
        currentLanguageBtn.backgroundColor = currentLanguage.colorPrimary
        currentLanguageBtn.setBackgroundImage(currentLanguage.flag, for: .normal)
        
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
    
    func styleButton(_ btn: UIButton) {
        btn.center.x = view.center.x
        
        btn.backgroundColor = currentLanguage.colorPrimary
        btn.contentHorizontalAlignment = .left
        
        btn.layer.borderColor = currentLanguage.colorTertiary?.cgColor
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
        
        btn.setTitleColor(currentLanguage.colorSecondary, for: .normal)
        btn.setTitleColor(currentLanguage.colorTertiary, for: .highlighted)
    }
    
    @objc func loadInterface() {
        view.backgroundColor = currentLanguage.colorPrimary
        
        let height = view.bounds.size.height / 8
        let width = view.bounds.width - 20
        var gap = CGFloat(10)
        
        currentLanguageBtn = UIButton(frame: CGRect(x: 0, y: height + gap, width: width, height: height))
        currentLanguageBtn.addTarget(self, action: #selector(selectLanguage), for: .touchUpInside)
        currentLanguageBtn.setBackgroundImage(currentLanguage.flag, for: .normal)
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
