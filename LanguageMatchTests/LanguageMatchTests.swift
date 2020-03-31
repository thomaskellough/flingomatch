//
//  LanguageMatchTests.swift
//  LanguageMatchTests
//
//  Created by Thomas Kellough on 3/29/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import XCTest
@testable import LanguageMatch

class LanguageMatchTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEnglishLanguagesWordCount() {
        // Loop through documents directy and pull out all language txt files
        let textFilesArray = getTxtFiles()
        
        // For each language txt file, create a Language() instance and determine the number of English words. If there is not at least 9 words loaded then there are not enough words to play the game.
        var wordCountArray = [(language: String, englishWordCount: Int)]()
        
        for file in textFilesArray {
            let languageString = file.replacingOccurrences(of: ".txt", with: "")
            let language = Language(name: languageString)
            
            wordCountArray += [(language: languageString, englishWordCount: language.englishWords!.count)]
        }
        
        let testArray = wordCountArray.filter { $0.englishWordCount < 9 }
        
        XCTAssertEqual(testArray.count, 0, "\nERROR: There was at least one language that had less than 9 words. Please see the list of languages below.\n\(testArray)")
        
    }
    
    func testForeignLanguagesWordCount() {
        // Loop through documents directy and pull out all language txt files
        let textFilesArray = getTxtFiles()
        
        // For each language txt file, create a Language() instance and determine the number of English words. If there is not at least 9 words loaded then there are not enough words to play the game.
        var wordCountArray = [(language: String, foreignWordCount: Int)]()
        
        for file in textFilesArray {
            let languageString = file.replacingOccurrences(of: ".txt", with: "")
            let language = Language(name: languageString)
            
            wordCountArray += [(language: languageString, foreignWordCount: language.foreignWords!.count)]
        }
        
        let testArray = wordCountArray.filter { $0.foreignWordCount < 9 }
        
        XCTAssertEqual(testArray.count, 0, "\nERROR: There was at least one language that had less than 9 words. Please see the list of languages below.\n\(testArray)")
        
    }
    
    func testWordCountEqual() {
        var countsDict = [String: [Int]]()
        let textFilesArray = getTxtFiles()
        
        for file in textFilesArray {
            let languageString = file.replacingOccurrences(of: ".txt", with: "")
            let language = Language(name: languageString)
            
            let englishWords = language.englishWords!.count
            let foreignWords = language.foreignWords!.count
            
            countsDict[languageString] = [englishWords, foreignWords]
        }
        
        let testDict = countsDict.filter { $0.value[0] != $0.value[1] }
        print(testDict)
        XCTAssertEqual(testDict.count, 0, "\nERROR: There was at least one language that had an unequal amount of English words and foreign words. The languages were:\n\(testDict)")
    }
    
    func testLanguageColorScheme() {
        // Loop through documents directy and pull out all language txt files
        let textFilesArray = getTxtFiles()
        
        // For each language txt file, create a Language() instance and determine primary, secondary, and tertiary colors. If all colors are white (default) it means there is no color scheme set up for that language.
        var whiteLanguageArray = [String]()
        
        for file in textFilesArray {
            let languageString = file.replacingOccurrences(of: ".txt", with: "")
            let language = Language(name: languageString)
            
            let colorPrimary = language.colorPrimary!
            let colorSecondary = language.colorSecondary!
            let colorTertiary = language.colorTertiary!
            
            if colorPrimary == UIColor.white {
                if colorSecondary == UIColor.white {
                    if colorTertiary == UIColor.white {
                        whiteLanguageArray.append(languageString)
                    }
                }
            }
        }
        
        XCTAssertEqual(whiteLanguageArray.count, 0, "\nERROR: You had \(whiteLanguageArray.count) language(s) that had UIColor.white as primary, secondary, and tertiary color. Please make sure you add a color scheme for each of the following languages in Language.swift.\n\(whiteLanguageArray)")
    }
    
    func getTxtFiles() -> [String] {
        var textFilesArray = [String]()
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasSuffix(".txt") {
                    textFilesArray.append(item)
                }
            }
        } catch {
            print("Failed to read directory")
        }
        
        return textFilesArray
    }

}
