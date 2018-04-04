//
//  Challenge_03.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/4/18.
//

import XCTest

/// Write a function that accepts two String parameters, and returns true if they contain the same characters in any order taking into account letter case.

func haveSameCharacters(_ strings: String...) -> Bool {
    guard let firstString = strings.first else { return false }

    let initialResult = (hasSameCharacters: true, str: firstString, set: Set(firstString))
    let result = strings.reduce(initialResult) { (res, value) in
        let valueSet = Set(value)
        if res.hasSameCharacters,
            res.str.count == value.count,
            res.set == valueSet {
            return(hasSameCharacters: true, str: value, set: valueSet)
        } else {
            return(hasSameCharacters: false, str: res.str, set: res.set)
        }
    }

    return result.hasSameCharacters
}

class Challenge_03: XCTestCase {

    func test01() {
        XCTAssertTrue(haveSameCharacters("abca", "abca"))
    }

    func test02() {
        XCTAssertTrue(haveSameCharacters("abc", "cba"))
    }

    func test03() {
        XCTAssertTrue(haveSameCharacters("a1 b2", "b1 a2"))
    }

    func test04() {
        XCTAssertFalse(haveSameCharacters("abc", "abca"))
    }

    func test05() {
        XCTAssertFalse(haveSameCharacters("abc", "Abc"))
    }

    func test06() {
        XCTAssertFalse(haveSameCharacters("abc", "cbAa"))
    }

    func test07() {
        XCTAssertTrue(haveSameCharacters("abc", "cab", "bca"))
    }

    func test08() {
        XCTAssertFalse(haveSameCharacters())
    }
}
