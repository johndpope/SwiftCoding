//
//  Challenge_05.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/5/18.
//

import XCTest

// Write a function that accepts a string, and returns how many times a specific character appears, taking case into account.

func count(character: Character, in str: String) -> Int {
    return str.filter { $0 == character }.count
}

func count(char: String, in str: String) -> Int {
    let temp = str.replacingOccurrences(of: char, with: "")
    return str.count - temp.count
}

class Challenge_05: XCTestCase {

    func test01() {
        XCTAssertEqual(count(character: "a", in: "The rain in Spain"), 2)
        XCTAssertEqual(count(char: "a", in: "The rain in Spain"), 2)
    }

    func test02() {
        XCTAssertEqual(count(character: "i", in: "Mississipi"), 4)
        XCTAssertEqual(count(char: "i", in: "Mississipi"), 4)
    }

    func test03() {
        XCTAssertEqual(count(character: "M", in: "Minimal"), 1)
        XCTAssertEqual(count(char: "M", in: "Minimal"), 1)
    }

}
