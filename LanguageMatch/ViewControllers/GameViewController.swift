//
//  GameViewController.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/3/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var compareDict = [String: String]()
    var imageIcon: UIImage!
    var imageFlagIcon1: UIImage!
    var imageFlagIcon2: UIImage!
    var numberTapped = 0
    var randomWords = [String]()
    var playMode: String?
    var setsWon = 0
    var tag1 = 0
    var tag2 = 0
    var word1: String!
    var word2: String!
    weak var delegate: ViewController!

    var flipsLabel: UILabel!
    var numberOfFlips = 0 {
        didSet {
            flipsLabel.text = "Flips: \(numberOfFlips)"
        }
    }
    
    var playerTurn: UILabel!
    var playerOneTurn = true {
        didSet {
            if playerOneTurn {
                playerTurn.text = "Turn: Player 1"
            } else {
                playerTurn.text = "Turn: Player 2"
            }
        }
    }
    
    var scoreLabelPlayerOne: UILabel!
    var scorePlayerOne = 0 {
        didSet {
            scoreLabelPlayerOne.text = "P1: \(scorePlayerOne)"
        }
    }
    
    var scoreLabelPlayerTwo: UILabel!
    var scorePlayerTwo = 0 {
        didSet {
            scoreLabelPlayerTwo.text = "P2: \(scorePlayerTwo)"
            
        }
    }
    
    var timer: Timer?
    var timerLabel: UILabel!
    var time = 60 {
        didSet {
            timerLabel.text = "Time Left: \(time)s"
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(onMainThread: #selector(loadGame), with: nil, waitUntilDone: false)
    }
    
    // Functions for Timed Play Mode
    func loadTimedPlayLabels(height: Int, width: Int) {
        var height = height
        if globalDevice == "ipadLarge" {
            height -= 75
        } else if globalDevice == "ipadSmall" {
            height -= 65
        } else if globalDevice == "iphoneReg" || globalDevice == "iphonePlus" {
            height -= 30
        } else if globalDevice == "iphoneSmall" {
            height -= 10
        }
        timerLabel = UILabel(frame: CGRect(x: 0, y: height, width: width, height: height * 2))
        timerLabel.font = UIFont(name: globalFont, size: globalFontSize)
        timerLabel.text = "Time left: 60s"
        timerLabel.textAlignment = .center
        timerLabel.textColor = delegate.currentLanguage.colorPrimary
        view.addSubview(timerLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeLeft() {
        time -= 1
        if time <= 0 {
            timer?.invalidate()
            time = 60
            endGame()
        }
    }
    
    // Function for Single Player Mode
    func loadSinglePlayerLabels(height: Int, width: Int) {
        var height = height
        if globalDevice == "ipadLarge" {
            height -= 75
        } else if globalDevice == "ipadSmall" {
            height -= 65
        } else if globalDevice == "iphoneReg" || globalDevice == "iphonePlus" {
            height -= 30
        } else if globalDevice == "iphoneSmall" {
            height -= 10
        }
        flipsLabel = UILabel(frame: CGRect(x: 0, y: height, width: width, height: height * 2))
        flipsLabel.font = UIFont(name: globalFont, size: globalFontSize)
        flipsLabel.text = "Flips: 0"
        flipsLabel.textAlignment = .center
        flipsLabel.textColor = delegate.currentLanguage.colorPrimary
        view.addSubview(flipsLabel)
    }
    
    // Function for Two Player Mode
    func loadTwoPlayerLabels(height: Int, width: Int, buttonWidth: Int) {
        var height = height
        if globalDevice == "ipadLarge" {
            height -= 70
        } else if globalDevice == "ipadSmall" {
            height -= 50
        } else if globalDevice == "iphoneReg" || globalDevice == "iphonePlus" {
            height -= 20
        } else if globalDevice == "iphoneSmall" {
            height -= 10
        }
        playerTurn = UILabel(frame: CGRect(x: 0, y: height / 2, width: width, height: height * 2))
        playerTurn.font = UIFont(name: globalFont, size: globalFontSize)
        playerTurn.text = "Turn: Player 1"
        playerTurn.textAlignment = .center
        playerTurn.textColor = delegate.currentLanguage.colorPrimary
        view.addSubview(playerTurn)
        
        if globalDevice == "ipadSmall" || globalDevice == "ipadLarge" {
            height -= 20
        } else if globalDevice == "iphoneReg" || globalDevice == "iphonePlus" {
            height -= 10
        } else if globalDevice == "iphoneSmall" {
            height -= 10
        }
        scoreLabelPlayerOne = UILabel(frame: CGRect(x: 0, y: height * 2, width: buttonWidth, height: height))
        scoreLabelPlayerOne.font = UIFont(name: globalFont, size: globalFontSize)
        scoreLabelPlayerOne.text = "P1: 0"
        scoreLabelPlayerOne.textAlignment = .center
        scoreLabelPlayerOne.textColor = delegate.currentLanguage.colorPrimary
        view.addSubview(scoreLabelPlayerOne)
        
        scoreLabelPlayerTwo = UILabel(frame: CGRect(x: buttonWidth * 2, y: height * 2, width: buttonWidth, height: height))
        scoreLabelPlayerTwo.font = UIFont(name: globalFont, size: globalFontSize)
        scoreLabelPlayerTwo.text = "P2: 0"
        scoreLabelPlayerTwo.textAlignment = .center
        scoreLabelPlayerTwo.textColor = delegate.currentLanguage.colorPrimary
        view.addSubview(scoreLabelPlayerTwo)
    }
    
    func loadImages(language: String) {
        let iconString = "icon\(delegate.currentLanguage.name)"
        imageFlagIcon1 = UIImage(named: "iconAmerica")
        imageFlagIcon2 = delegate.currentLanguage.flag
        imageIcon = UIImage(named: iconString)
    }
    
    // Function all play modes share
    @objc func loadGame() {
        self.view.removeAllSubviews()
        self.view.backgroundColor = delegate.currentLanguage.colorSecondary
        loadImages(language: delegate.currentLanguage.name)
        setsWon = 0
        randomWords = randomSets()
        assert(!randomWords.isEmpty, "Error: Random words are empty. Please check randomSets function to determine reason for early return.")
        guard let englishWords = delegate.currentLanguage.englishWords else { return }
        assert(englishWords.count > 9, "Error: Could only load \(englishWords.count) english words when we need at least 9.")
        var count = 0
        
        let labelWidth = Int(view.bounds.size.width)
        let buttonWidth = (labelWidth / 3) - 10
        var height = Int(Float(buttonWidth) / 1.5)
        if globalDevice == "ipadSmall" || globalDevice == "ipadLarge" {
            height = Int(labelWidth / 6)
        }
        var xGap = (Int(view.bounds.size.width) - (buttonWidth * 3)) / 4
        var yGap = xGap
        if globalDevice == "ipadLarge" {
            yGap -= 235
        } else if globalDevice == "ipadSmall" {
            yGap -= 200
        } else if globalDevice == "iphoneReg" || globalDevice == "iphonePlus" {
            yGap -= 85
        } else if globalDevice == "iphoneSmall" {
            yGap -= 60
        }
        let spacer = xGap
        
        if playMode == "timed" {
            loadTimedPlayLabels(height: height, width: labelWidth)
        } else if playMode == "single" {
            loadSinglePlayerLabels(height: height, width: labelWidth)
        } else if playMode == "two" {
            loadTwoPlayerLabels(height: height, width: labelWidth, buttonWidth: buttonWidth)
        }
        
        // TODO: Add support for landscape mode. Will probably have to re-write with constraints
        for row in 1...6 {
            xGap = spacer
            for col in 1...3 {
                let wordButton = UIButton(type: .system)
                wordButton.addTarget(self, action: #selector(wordTapped), for: .touchUpInside)
                //wordButton.setTitleColor(globalPrimaryColor, for: .normal)
                wordButton.setTitleColor(delegate.currentLanguage.colorSecondary, for: .normal)
                wordButton.tag = count + 1
                wordButton.titleLabel?.adjustsFontSizeToFitWidth = true
                wordButton.titleLabel?.font = UIFont.systemFont(ofSize: globalFontSize)
                wordButton.titleLabel?.numberOfLines = 1
                wordButton.titleLabel?.sizeToFit()
                if delegate.hardMode! {
                    wordButton.setBackgroundImage(imageIcon, for: .normal)
                } else {
                    if englishWords.contains(randomWords[wordButton.tag - 1]) {
                        wordButton.setBackgroundImage(imageFlagIcon1, for: .normal)
                    } else {
                        wordButton.setBackgroundImage(imageFlagIcon2, for: .normal)
                    }
                }
//                 wordButton.setTitle(randomWords[wordButton.tag - 1], for: .normal) // uncomment to view words without flipping - testing purposes
                
                wordButton.clipsToBounds = true
                wordButton.layer.borderColor = delegate.currentLanguage.colorTertiary?.cgColor
                wordButton.layer.borderWidth = 1
                wordButton.layer.cornerRadius = 5
                wordButton.layer.shadowColor = delegate.currentLanguage.colorPrimary?.cgColor
                wordButton.layer.shadowOffset = CGSize(width: 1, height: 1)
                wordButton.layer.shadowOpacity = 0.8
                wordButton.layer.shadowRadius = 2
                wordButton.backgroundColor = delegate.currentLanguage.colorPrimary
                
                let frame = CGRect(x: (col * buttonWidth) - buttonWidth + xGap, y: (row * height) + (2 * height) + yGap, width: buttonWidth, height: height)
                wordButton.frame = frame
                
                view.addSubview(wordButton)
                count += 1
                xGap += spacer
            }
            yGap += spacer
        }
        view.isUserInteractionEnabled = true
    }
    
    func restartGame(action: UIAlertAction) {
        performSelector(onMainThread: #selector(loadGame), with: nil, waitUntilDone: false)
    }
    
    func randomSets() -> [String] {
        guard var pairs = delegate.currentLanguage.pairs else { return [] }
        var randomPairs = [Pair]()
        var randomWords = [String]()
        
        pairs.shuffle()
        for i in 0 ..< 9 {
            randomPairs.append((pairs[i]))
 
        }
        assert(randomPairs.count == 9, "Error: Pairs was a total of \(String(describing: randomPairs.count)) when it should have been 9.")
        for randomPair in randomPairs {
            word1 = randomPair.wordOne
            word2 = randomPair.wordTwo
            randomWords.append(word1)
            randomWords.append(word2)
            compareDict[word1] = word2
        }
        
        randomWords.shuffle()
        return randomWords
        
    }
    
    func flip(_ button: UIButton, _ tag: Int) {
        button.backgroundColor = delegate.currentLanguage.colorTertiary
        button.layer.borderColor = delegate.currentLanguage.colorPrimary?.cgColor
        button.setTitleColor(delegate.currentLanguage.colorSecondary, for: .normal)
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromTop]
        UIView.transition(with: button, duration: 1.0, options: transitionOptions, animations: {
            button.setBackgroundImage(nil, for: .normal)
            button.setTitle(self.randomWords[tag - 1], for: .normal)
        })
    }
    
    func flipBack(_ button: UIButton) {
        guard let englishWords = delegate.currentLanguage.englishWords else { return }
        button.backgroundColor = delegate.currentLanguage.colorPrimary
        button.layer.borderColor = delegate.currentLanguage.colorTertiary?.cgColor
        button.setTitleColor(delegate.currentLanguage.colorSecondary, for: .normal)
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom]
        UIView.transition(with: button, duration: 1.0, options: transitionOptions, animations: {
            if self.delegate.hardMode! {
                button.setBackgroundImage(self.imageIcon, for: .normal)
            } else {
                if englishWords.contains(self.randomWords[button.tag - 1]) {
                    button.setBackgroundImage(self.imageFlagIcon1, for: .normal)
                } else {
                    button.setBackgroundImage(self.imageFlagIcon2, for: .normal)
                }
            }
            button.setTitle(nil, for: .normal)
        })
    }
    
    func removeButton(_ button: UIButton) {
        UIView.animate(withDuration: 1, animations:  {
            button.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) {_ in
            button.removeFromSuperview()
        }
    }
    
    func revealCard(_ button: UIButton, tag: Int) {
        flip(button, tag)
        numberTapped += 1
        
        if numberTapped == 1 {
            word1 = randomWords[tag - 1]
            tag1 = tag
        } else {
            word2 = randomWords[tag - 1]
            tag2 = tag
            compareCards()
        }
    }
    
    func compareCards() {
        self.view.isUserInteractionEnabled = false
        guard let buttonOne = self.view.viewWithTag(tag1) as? UIButton else { return }
        guard let buttonTwo = self.view.viewWithTag(tag2) as? UIButton else { return }
        if playMode == "single" {
            numberOfFlips += 1
        }
        
        if compareDict[word1] == word2 {
            self.view.isUserInteractionEnabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.removeButton(buttonOne)
                self.removeButton(buttonTwo)
                if self.playMode == "two" { self.incrementScore() }
                self.setsWon += 1
                if self.setsWon == 9 {
                    self.endGame()
                }
            }
        } else if compareDict[word2] == word1 {
            self.view.isUserInteractionEnabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.removeButton(buttonOne)
                self.removeButton(buttonTwo)
                if self.playMode == "two" { self.incrementScore() }
                self.setsWon += 1
                if self.setsWon == 9 {
                    self.endGame()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.flipBack(buttonOne)
                self.flipBack(buttonTwo)
                self.view.isUserInteractionEnabled = true
                if self.playMode == "two" { self.playerOneTurn.toggle() }
            }
        }
        
        numberTapped = 0
        
    }
    
    func incrementScore() {
        if playerOneTurn {
            scorePlayerOne += 1
        } else {
            scorePlayerTwo += 1
        }
    }
    
    func endGame() {
        timer?.invalidate()
        view.isUserInteractionEnabled = false
        var message: String
        if playMode == "single" {
            message = "Good job! You did it!"
        } else if playMode == "two" {
            if scorePlayerOne > scorePlayerTwo {
                message = "Player 1 wins!"
            } else if scorePlayerTwo > scorePlayerOne {
                message = "Player 2 wins!"
            } else {
                message = "It’s a tie!"
            }
        } else {
            if setsWon == 9 {
                message = "Good job! You found every match in time!"
            } else {
                message = "Good try! Next time you'll get all the cards!"
            }
        }
        
        setsWon = 0
        let ac = UIAlertController(title: "Game over!", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Play again!", style: .default, handler: restartGame))
        present(ac, animated: true)
    }
    
    @objc func wordTapped(_ sender: UIButton) {
        let tag = sender.tag
        revealCard(sender, tag: tag)
    }
}
