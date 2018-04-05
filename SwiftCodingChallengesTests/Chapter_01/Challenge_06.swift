//
//  Challenge_06.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/5/18.
//

import XCTest

/// Write a function that accepts a string as its input, and returns the same string just with duplicate letters removed.

private extension String {

    func uniqueCharacters() -> String {
        return self.reduce((filteredString: "", uniqueCharacteres: Set<Character>())) { (result, character) in
            if result.uniqueCharacteres.contains(character) {
                return result
            } else {
                // Degrades performance by having to create new values
                let updatedString = result.filteredString + String(character)
                var updatedUniqueCharacters = result.uniqueCharacteres
                updatedUniqueCharacters.insert(character)
                return (updatedString, updatedUniqueCharacters)
            }
        }.filteredString
    }

    func uniqueLetters() -> String {
        var uniqueLetters = Set<Character>()
        return self.filter { (character) in
            if !uniqueLetters.contains(character) {
                uniqueLetters.insert(character)
                return true
            } else {
                return false
            }
        }
    }

    func unique() -> String {
        var uniqueLetters = [Character]()
        return self.filter { (character) in
            // Line below degrades performance 600% compared to uniqueLetters
            if !uniqueLetters.contains(character) {
                uniqueLetters.append(character)
                return true
            } else {
                return false
            }
        }
    }
}
class Challenge_06: XCTestCase {

    func test01() {
        XCTAssertEqual("wombat".uniqueCharacters(), "wombat")
        XCTAssertEqual("wombat".uniqueLetters(), "wombat")
    }

    func test02() {
        XCTAssertEqual("hello".uniqueCharacters(), "helo")
        XCTAssertEqual("hello".uniqueLetters(), "helo")
    }

    func test03() {
        XCTAssertEqual("Mississipi".uniqueCharacters(), "Misp")
        XCTAssertEqual("Mississipi".uniqueLetters(), "Misp")
    }

    func testP01() {
        let input = String(repeating: "abcdefghijklmnopqrstuvwxyz", count: 10)
        measure {
            _ = input.uniqueCharacters()
        }
    }

    func testP02() {
        let input = String(repeating: "abcdefghijklmnopqrstuvwxyz", count: 10)
        measure {
            _ = input.uniqueLetters()
        }
    }

    func testP03() {
        let input = String(repeating: "abcdefghijklmnopqrstuvwxyz", count: 10)
        measure {
            _ = input.unique()
        }

    }

}
