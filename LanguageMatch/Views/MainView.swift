//
//  MainView.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 6/28/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import UIKit


class MainView: UIView {
    
    // MARK: Main Buttons
    var timedPlayBtn: UIButton!
    var singlePlayerBtn: UIButton!
    var twoPlayerBtn: UIButton!
    var studyBtn: UIButton!
    var settingsBtn: UIButton!
    
    // MARK: Button Action Closures
    var chooseLanguageAction: (() -> Void)?
    var timedPlayAction: (() -> Void)?
    var singlePlayerAction: (() -> Void)?
    var twoPlayerAction: (() -> Void)?
    var studyAction: (() -> Void)?
    var settingsAction: (() -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    init(_ language: Language,
         chooseLanguageAction: @escaping() -> Void,
         timedPlayAction: @escaping() -> Void,
         singlePlayerAction: @escaping() -> Void,
         twoPlayerAction: @escaping() -> Void,
         studyAction: @escaping() -> Void,
         settingsAction: @escaping() -> Void) {
        
        self.chooseLanguageAction = chooseLanguageAction
        self.timedPlayAction = timedPlayAction
        self.singlePlayerAction = singlePlayerAction
        self.twoPlayerAction = twoPlayerAction
        self.studyAction = studyAction
        self.settingsAction = settingsAction
        super.init(frame: .zero)
        
        backgroundColor = language.colorSecondary
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)
        
        let timedIcon = UIImage(named: "timed")
        let singlePlayerIcon = UIImage(named: "onePlayer")
        let twoPlayerIcon = UIImage(named: "twoPlayer")
        let studyIcon = UIImage(named: "study")
        let settingsIcon = UIImage(named: "settings")
        let icons: [UIImage?] = [timedIcon, singlePlayerIcon, twoPlayerIcon, studyIcon, settingsIcon]
        
        let titles: [String] = ["Timed Play", "Single Player", "Two Player", "Study Words", "Settings"]
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8)
        ])
        
        let languageButton = UIButton()
        languageButton.addTarget(self, action: #selector(chooseLanguage), for: .touchUpInside)
        languageButton.translatesAutoresizingMaskIntoConstraints = false
        languageButton.layer.masksToBounds = true
        languageButton.setBackgroundImage(language.flag, for: .normal)
        configureBorders(of: languageButton, with: language)
        stackView.addArrangedSubview(languageButton)

        timedPlayBtn = UIButton()
        singlePlayerBtn = UIButton()
        twoPlayerBtn = UIButton()
        studyBtn = UIButton()
        settingsBtn = UIButton()
        
        let buttons: [UIButton] = [timedPlayBtn, singlePlayerBtn, twoPlayerBtn, studyBtn, settingsBtn]
        
        timedPlayBtn.addTarget(self, action: #selector(timedPlay), for: .touchUpInside)
        singlePlayerBtn.addTarget(self, action: #selector(singlePlay), for: .touchUpInside)
        twoPlayerBtn.addTarget(self, action: #selector(twoPlay), for: .touchUpInside)
        studyBtn.addTarget(self, action: #selector(study), for: .touchUpInside)
        settingsBtn.addTarget(self, action: #selector(settings), for: .touchUpInside)
        
        for (index, button) in buttons.enumerated() {
            configureBorders(of: button, with: language)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = language.colorPrimary
            button.contentHorizontalAlignment = .left
            button.setImage(icons[index], for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
            button.setTitle(titles[index], for: .normal)
            button.setTitleColor(language.colorTertiary, for: .highlighted)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            button.titleLabel?.layer.shadowColor = UIColor.black.cgColor
            button.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
            button.titleLabel?.layer.shadowOpacity = 0.8
            button.titleLabel?.layer.shadowRadius = 5
            
            stackView.addArrangedSubview(button)
        }

        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
    }
    
    func configureBorders(of button: UIButton, with language: Language) {
        button.layer.borderColor = language.colorTertiary?.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
    }
    
    @objc func chooseLanguage() {
        chooseLanguageAction?()
    }
    
    @objc func timedPlay() {
        timedPlayAction?()
    }
    
    @objc func singlePlay() {
        singlePlayerAction?()
    }
    
    @objc func twoPlay() {
        twoPlayerAction?()
    }
    
    @objc func study() {
        studyAction?()
    }
    
    @objc func settings() {
        settingsAction?()
    }
}
