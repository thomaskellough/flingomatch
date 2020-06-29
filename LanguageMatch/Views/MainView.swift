//
//  MainView.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 6/28/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import UIKit


class MainView: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }
    
    init(_ language: Language) {
        super.init(frame: .zero)
        
        backgroundColor = language.colorPrimary
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)
        
        let timedStack = UIStackView()
        let singlePlayerStack = UIStackView()
        let twoPlayerStack = UIStackView()
        let studyStack = UIStackView()
        let settingsStack = UIStackView()
        let vStacks: [UIStackView] = [timedStack, singlePlayerStack, twoPlayerStack, studyStack, settingsStack]
        
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
        languageButton.translatesAutoresizingMaskIntoConstraints = false
        languageButton.setBackgroundImage(language.flag, for: .normal)
        languageButton.layer.cornerRadius = 10
        languageButton.layer.masksToBounds = true
        languageButton.layer.borderWidth = 2
        languageButton.layer.borderColor = language.colorTertiary?.cgColor
        stackView.addArrangedSubview(languageButton)

        for (index, stack) in vStacks.enumerated() { 
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            
            let icon = icons[index]
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(icon, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
            button.setTitle(titles[index], for: .normal)
            button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            button.setTitleColor(language.colorTertiary, for: .highlighted)
            button.contentHorizontalAlignment = .left
            button.backgroundColor = language.colorPrimary
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
            button.layer.borderColor = language.colorTertiary?.cgColor
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.8
            button.layer.shadowRadius = 5
            button.layer.shadowOffset = CGSize(width: 3, height: 3)
            button.titleLabel?.layer.shadowColor = UIColor.black.cgColor
            button.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
            button.titleLabel?.layer.shadowOpacity = 0.8
            button.titleLabel?.layer.shadowRadius = 5
            
            stack.addArrangedSubview(button)
            stackView.addArrangedSubview(stack)
        }

        
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
//        let imageView = UIImageView(image: UIImage(named: "timed"))
//        imageView.backgroundColor = language.colorPrimary
//        imageView.contentMode = .scaleAspectFit
//        timedStack.addArrangedSubview(imageView)
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Timed Play"
//        label.backgroundColor = language.colorPrimary
//        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
//        label.textColor = .white
//        timedStack.addArrangedSubview(label)

//
//
//        let timedPlayButton = UIButton()
//        timedPlayButton.translatesAutoresizingMaskIntoConstraints = false
//        timedPlayButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        timedPlayButton.setTitle("  Timed Play", for: .normal)
//        timedPlayButton.setImage(UIImage(named: "timed"), for: .normal)
//
//        let singlePlayerButton = UIButton()
//        singlePlayerButton.translatesAutoresizingMaskIntoConstraints = false
//        singlePlayerButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        singlePlayerButton.setTitle("  Single Player", for: .normal)
//        singlePlayerButton.setImage(UIImage(named: "onePlayer"), for: .normal)
//
//        let twoPlayerButton = UIButton()
//        twoPlayerButton.translatesAutoresizingMaskIntoConstraints = false
//        twoPlayerButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        twoPlayerButton.setTitle("  Two Player", for: .normal)
//        twoPlayerButton.setImage(UIImage(named: "twoPlayer"), for: .normal)
//
//        let studyButton = UIButton()
//        studyButton.translatesAutoresizingMaskIntoConstraints = false
//        studyButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        studyButton.setTitle("  Study Words", for: .normal)
//        studyButton.setImage(UIImage(named: "study"), for: .normal)
//
//        let settingsButton = UIButton()
//        settingsButton.translatesAutoresizingMaskIntoConstraints = false
//        settingsButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        settingsButton.setTitle("  Settings", for: .normal)
//        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
//
//
//
//        stackView.addArrangedSubview(timedStack)
//
//        stackView.addArrangedSubview(singlePlayerButton)
//        stackView.addArrangedSubview(twoPlayerButton)
//        stackView.addArrangedSubview(studyButton)
//        stackView.addArrangedSubview(settingsButton)
    }
}
