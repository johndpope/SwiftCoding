//
//  Challenge_11.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/10/18.
//

import XCTest

/// Write a function that accepts two strings, and returns true if they are identical in length but have no more than three different letters, taking case and string order into account.

func areEqual(_ lhs: String, _ rhs: String, tolerance: Int) -> Bool {
    return Array(lhs).isEqual(Array(rhs), tolerance: tolerance)
}

private extension Array where Element: Equatable{

    func isEqual(_ aArray: Array, tolerance: Int) -> Bool {
        guard self.count == aArray.count else { return false }

        var runner = 0
        var differentElements = 0
        while runner < self.count && runner < aArray.count {
            differentElements += self[runner] != aArray[runner] ? 1 : 0
            if differentElements > tolerance { return false }
            runner += 1
        }
        return true
    }
}

class Challenge_11: XCTestCase {

    func test01() {
        XCTAssertTrue(areEqual("Clamp", "Cramp", tolerance: 3))
        XCTAssertTrue(areEqual("Clamp", "Crams", tolerance: 3))
        XCTAssertTrue(areEqual("Clamp", "Grams", tolerance: 3))
        XCTAssertFalse(areEqual("Clamp", "Grans", tolerance: 3))
        XCTAssertFalse(areEqual("Clamp", "Clam", tolerance: 3))
        XCTAssertFalse(areEqual("clamp", "maple", tolerance: 3))
        XCTAssertFalse(areEqual("test", "tests", tolerance: 3))
        XCTAssertTrue(areEqual("abc", "def", tolerance: 3))
        XCTAssertFalse(areEqual("abcd", "efgh", tolerance: 3))
    }
}
