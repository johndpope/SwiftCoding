//
//  Challenge_01.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/2/18.
//

import XCTest

/// Write a function that accepts a String as its only parameter, and returns true if the string has only unique letters, taking letter case into account.

private extension String {

    func hasUniqueCharacters() -> Bool {
        return Set(self).count == self.count
    }
}

class Challenge_01: XCTestCase {

    func test01() {
        XCTAssertTrue("No duplicates".hasUniqueCharacters())
    }

    func test02() {
        XCTAssertTrue("abcdefghijklmnopqrstuvwxyz".hasUniqueCharacters())
    }

    func test03() {
        XCTAssertTrue("AaBbCc".hasUniqueCharacters())
    }

    func test04() {
        XCTAssertFalse("Hello, world".hasUniqueCharacters())
    }
}
