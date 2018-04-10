//
//  Challenge_12.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/10/18.
//

import XCTest

/// Write a function that accepts a string of words with a similar prefix, separated by spaces, and returns the longest substring that prefixes all words.

func longestPrefix(words: [String]) -> String {
    guard let firstWord = words.first else { return "" }

    var prefix = ""
    for letter in firstWord {
        let tempPrefix = prefix + String(letter)
        let match = words.reduce(true) { (result, word) in
            return word.hasPrefix(tempPrefix)
        }
        if match {
            prefix = tempPrefix
        } else {
            break
        }
    }
    return prefix
}

func longestPrefix(words: String...) -> String {
    return longestPrefix(words: words)
}

func longestPrefix(in words: String) -> String {
    let t = words.split(separator: " ").map { String($0) }
    return longestPrefix(words: t)
}

class Challenge_12: XCTestCase {

    func test01() {
        XCTAssertEqual(longestPrefix(words: "swift", "switch", "swill", "swim"), "swi")
        XCTAssertEqual(longestPrefix(words: "flip", "flap", "flop"), "fl")
    }

    func test02() {
        XCTAssertEqual(longestPrefix(in: "swift switch swill swim"), "swi")
        XCTAssertEqual(longestPrefix(in: "flip flap flop"), "fl")
    }

    func test03() {
        XCTAssertEqual(longestPrefix(words: " ", "switch", "swill", "swim"), "")
        XCTAssertEqual(longestPrefix(in: "  swift switch swill swim"), "swi")
    }

    func test04() {
        XCTAssertEqual(longestPrefix(words: " "), " ")
        XCTAssertEqual(longestPrefix(in: ""), "")
    }
}
