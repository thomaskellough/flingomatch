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
    
    func testFrenchLanguageWordCount() {
        let language = Language(name: "French")
        let englishCount = language.englishWords?.count
        XCTAssertNotNil(englishCount)
        XCTAssertGreaterThan(englishCount!, 9)
    }
    
    func testItalianLanguageWordCount() {
        let language = Language(name: "Italian")
        let englishCount = language.englishWords?.count
        XCTAssertNotNil(englishCount)
        XCTAssertGreaterThan(englishCount!, 9)
    }
    
    func testSpanishLanguageWordCount() {
        let language = Language(name: "Spanish")
        let englishCount = language.englishWords?.count
        XCTAssertNotNil(englishCount)
        XCTAssertGreaterThan(englishCount!, 9)
    }

}
