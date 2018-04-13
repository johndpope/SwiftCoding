//
//  Challenge_15.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/13/18.
//

import XCTest

/// Write a function that returns a string with each of its words reversed but in the original order, without using a loop.

private extension String {

    func reverseWords() -> String {
        let words = split(separator: " ")
        let reversedWords = words.map { String($0.reversed()) }
        return reversedWords.joined(separator: " ")
    }
}

class Challenge_15: XCTestCase {

    func test01() {
        XCTAssertEqual("Swift Coding Challenges".reverseWords(), "tfiwS gnidoC segnellahC")
        XCTAssertEqual("The quick brown fox".reverseWords(), "ehT kciuq nworb xof")
    }
}
