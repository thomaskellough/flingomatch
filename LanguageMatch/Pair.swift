//
//  Pair.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/2/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Pair: NSObject {
    
    var wordOne: String?
    var wordTwo: String?
    
    init(wordOne: String, wordTwo: String) {
        self.wordOne = wordOne
        self.wordTwo = wordTwo
    }
}

