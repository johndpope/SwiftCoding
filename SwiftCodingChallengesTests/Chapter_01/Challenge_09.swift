//
//  Challenge_09.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/6/18.
//

import XCTest

/// Write a function that returns true if it is given a string that is an English pangram, ignoring letter case.

private extension String {
    func isPangram() -> Bool {
        let set = Set(self.lowercased())
        let filteredSet = set.filter {
            $0 >= "a" && $0 <= "z"
        }
        return filteredSet.count == 26
    }

    func isPangram2() -> Bool {
        let set = Set(self.lowercased().replacingOccurrences(of: " ", with: ""))
        guard set.count == 26 else { return false }
        let characterSet = CharacterSet.lowercaseLetters
        return set.reduce(true, { (result, character) in
            guard result else { return result }
            return character.unicodeScalars.reduce(true, { (result, unicodeScalar) in
                return result ? characterSet.contains(unicodeScalar) : result
            })
        })
    }
}

class Challenge_09: XCTestCase {

    func test01() {
        XCTAssertTrue("The quick brown fox jumps over the lazy dog".isPangram())
        XCTAssertTrue("The quick brown fox jumps over the lazy dog".isPangram2())
    }

    func test02() {
        XCTAssertFalse("The quick brown fox jumped over the lazy dog".isPangram())
        XCTAssertFalse("The quick brown fox jumped over the lazy dog".isPangram2())
    }

}
