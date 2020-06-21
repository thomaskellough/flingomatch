//
//  Country.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 3/28/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import UIKit

struct Language {
    var name: String
    var flag: UIImage?
    var colorPrimary: UIColor?
    var colorSecondary: UIColor?
    var colorTertiary: UIColor?
    var englishWords: [String]?
    var foreignWords: [String]?
    var pairs: [Pair]?
    
    init(name: String) {
        self.name = name
        self.flag = Flags().renderFlag(language: name)
        
        self.setColors(name: name)
        loadWords()
    }
    
    mutating func setColors(name: String) {
        switch name {
        case "French":
            self.colorPrimary = UIColor.French.primary
            self.colorSecondary = UIColor.French.secondary
            self.colorTertiary = UIColor.French.tertiary
        case "Italian":
            self.colorPrimary = UIColor.Italian.primary
            self.colorSecondary = UIColor.Italian.secondary
            self.colorTertiary = UIColor.Italian.tertiary
        case "Spanish":
            self.colorPrimary = UIColor.Spanish.primary
            self.colorSecondary = UIColor.Spanish.secondary
            self.colorTertiary = UIColor.Spanish.tertiary
        case "German":
            self.colorPrimary = UIColor.German.primary
            self.colorSecondary = UIColor.German.secondary
            self.colorTertiary = UIColor.German.tertiary
        default:
            self.colorPrimary = UIColor.white
            self.colorSecondary = UIColor.white
            self.colorTertiary = UIColor.white
        }
    }
    
    mutating func loadWords() {
        englishWords = []
        foreignWords = []
        pairs = [Pair]()
        
        if let wordFileURL = Bundle.main.url(forResource: self.name, withExtension: "txt") {
            if let wordContents = try? String(contentsOf: wordFileURL) {
                let lines = wordContents.components(separatedBy: "\n")
                
                for line in lines {
                    let parts = line.components(separatedBy: ": ")
                    let wordOne = parts[0]
                    let wordTwo = parts[1]
                    englishWords?.append(wordOne)
                    foreignWords?.append(wordTwo)
                    
                    let pair = Pair(wordOne: wordOne, wordTwo: wordTwo)
                    pairs?.append(pair)
                }
            }
        }
    }
}
