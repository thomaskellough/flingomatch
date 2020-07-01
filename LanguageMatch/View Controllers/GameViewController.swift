//
//  GameViewController.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/3/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, Storyboarded {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    
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
    
    // Both these variables are used for unit testing only
    var englishFlags: Int = 0
    var foreignFlags: Int = 0

    var numberOfFlips = 0 {
        didSet {
            gameTitleLabel.text = "Flips: \(numberOfFlips)"
        }
    }

    var playerOneTurn = true {
        didSet {
            if playerOneTurn {
                gameTitleLabel.text = "Turn: Player 1"
            } else {
                gameTitleLabel.text = "Turn: Player 2"
            }
        }
    }

    var scorePlayerOne = 0 {
        didSet {
            playerOneScoreLabel.text = "P2: \(scorePlayerOne)"
        }
    }

    var scorePlayerTwo = 0 {
        didSet {
            playerTwoScoreLabel.text = "P2: \(scorePlayerTwo)"
        }
    }
    
    var timer: Timer?
    var time = 60 {
        didSet {
            gameTitleLabel.text = "Time Left: \(time)s"
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(onMainThread: #selector(loadGame), with: nil, waitUntilDone: false)
    }
    
    func loadTimedPlayLabels() {
        gameTitleLabel.text = "Time left: 60s"
        gameTitleLabel.textColor = ViewController.currentLanguage.colorPrimary
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
        playerOneScoreLabel.text = nil
        playerTwoScoreLabel.text = nil
    }
    
    @objc func updateTimeLeft() {
        time -= 1
        if time <= 0 {
            timer?.invalidate()
            time = 60
            endGame()
        }
    }
    
    func loadSinglePlayerLabels() {
        gameTitleLabel.text = "Flips: 0"
        gameTitleLabel.textColor = ViewController.currentLanguage.colorPrimary
        playerOneScoreLabel.text = nil
        playerTwoScoreLabel.text = nil
    }
    
    func loadTwoPlayerLabels() {
        gameTitleLabel.text = "Turn: Player 1"
        gameTitleLabel.textColor = ViewController.currentLanguage.colorPrimary
        playerOneScoreLabel.text = "P1: 0"
        playerOneScoreLabel.textColor = ViewController.currentLanguage.colorPrimary
        playerTwoScoreLabel.text = "P2: 0"
        playerTwoScoreLabel.textColor = ViewController.currentLanguage.colorPrimary
    }
    
    func loadImages(language: String) {
        imageFlagIcon1 = UIImage(named: "iconAmerica")
        imageFlagIcon2 = ViewController.currentLanguage.flag
        imageIcon = UIImage(named: "iconTransparent256.png")
    }
    
    // Function all play modes share
    @objc func loadGame() {
        mainView.backgroundColor = ViewController.currentLanguage.colorSecondary
        loadImages(language: ViewController.currentLanguage.name)
        setsWon = 0
        time = 60
        randomWords = randomSets()
        guard let englishWords = ViewController.currentLanguage.englishWords else { return }

        assert(!randomWords.isEmpty, "Error: Random words are empty. Please check randomSets function to determine reason for early return.")
        assert(englishWords.count > 9, "Error: Could only load \(englishWords.count) english words when we need at least 9.")
        
        if playMode == "timed" {
            loadTimedPlayLabels()
        } else if playMode == "single" {
            loadSinglePlayerLabels()
        } else if playMode == "two" {
            loadTwoPlayerLabels()
        }
        
        // TODO: Add support for landscape mode.
        for btn in cardButtons {
            btn.addTarget(self, action: #selector(wordTapped), for: .touchUpInside)
            btn.setTitleColor(ViewController.currentLanguage.colorSecondary, for: .normal)
            if ViewController.hardMode! {
                btn.setImage(imageIcon, for: .normal)
            } else {
                if englishWords.contains(randomWords[btn.tag - 1]) {
                    englishFlags += 1 // used for unit testing
                    btn.setImage(imageFlagIcon1, for: .normal)
                } else {
                    foreignFlags += 1 // used for unit testing
                    btn.setImage(imageFlagIcon2, for: .normal)
                }
            }
            
            btn.backgroundColor = ViewController.currentLanguage.colorPrimary
            btn.imageView?.contentMode = .scaleToFill
            btn.layer.borderColor = ViewController.currentLanguage.colorTertiary?.cgColor
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius = 5
            btn.layer.shadowColor = ViewController.currentLanguage.colorPrimary?.cgColor
            btn.layer.shadowOffset = CGSize(width: 1, height: 1)
            btn.layer.shadowOpacity = 0.8
            btn.layer.shadowRadius = 2
            btn.titleLabel?.numberOfLines = 0
            btn.isUserInteractionEnabled = true
            
             // Remove comments to view words without flipping - testing purposes
//            btn.setTitle(randomWords[btn.tag - 1], for: .normal)
//            btn.setImage(nil, for: .normal)
            
            view.isUserInteractionEnabled = true
        }
    }
    
    func restartGame(action: UIAlertAction) {
        performSelector(onMainThread: #selector(loadGame), with: nil, waitUntilDone: false)
    }
    
    func randomSets() -> [String] {
        guard var pairs = ViewController.currentLanguage.pairs else { return [] }
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
        button.backgroundColor = ViewController.currentLanguage.colorTertiary
        button.layer.borderColor = ViewController.currentLanguage.colorPrimary?.cgColor
        button.setTitleColor(ViewController.currentLanguage.colorSecondary, for: .normal)
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromTop]
        UIView.transition(with: button, duration: 1.0, options: transitionOptions, animations: {
            button.setImage(nil, for: .normal)
            button.setTitle(self.randomWords[tag - 1], for: .normal)
        })
    }
    
    func flipBack(_ button: UIButton) {
        guard let englishWords = ViewController.currentLanguage.englishWords else { return }
        button.backgroundColor = ViewController.currentLanguage.colorPrimary
        button.layer.borderColor = ViewController.currentLanguage.colorTertiary?.cgColor
        button.setTitleColor(ViewController.currentLanguage.colorSecondary, for: .normal)
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromBottom]
        UIView.transition(with: button, duration: 1.0, options: transitionOptions, animations: {
            if ViewController.hardMode! {
                button.setImage(self.imageIcon, for: .normal)
            } else {
                if englishWords.contains(self.randomWords[button.tag - 1]) {
                    button.setImage(self.imageFlagIcon1, for: .normal)
                } else {
                    button.setImage(self.imageFlagIcon2, for: .normal)
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
                self.setsWon += 1
                if self.playMode == "two" { self.incrementScore() }
                if self.setsWon == 9 {
                    self.endGame()
                } else {
                    self.deactivateCards([buttonOne, buttonTwo])
                }
            }
        } else if compareDict[word2] == word1 {
            self.view.isUserInteractionEnabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.setsWon += 1
                if self.playMode == "two" { self.incrementScore() }
                if self.setsWon == 9 {
                    self.endGame()
                } else {
                    self.deactivateCards([buttonOne, buttonTwo])
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
    
    func deactivateCards(_ cards: [UIButton]) {
        cards.forEach { deactivateAnimation($0) }
    }
    
    func deactivateAnimation(_ card: UIButton) {
        let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve]
        UIView.transition(with: card, duration: 1.0, options: transitionOptions, animations: {
            card.backgroundColor = nil
            card.layer.borderColor = nil
            card.isUserInteractionEnabled = false
            card.setTitle(nil, for: .normal)
            card.setBackgroundImage(nil, for: .normal)
        })
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
