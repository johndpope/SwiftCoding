//
//  Challenge_08.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/6/18.
//

import XCTest

/// Write a function that accepts two strings, and returns true if one string is rotation of the other, taking letter case into account.

private extension String {

    func isRotation(of str: String) -> Bool {
        guard self.count == str.count else { return false }
        let baseline = self + self
        return baseline.contains(str)
    }

    func isRotation(_ str: String) -> Bool {
        var isRotation = false
        _ = self.reduce(self) { (result, char) -> String in
            var temp = result + String(char)
            temp.removeFirst()
            if temp == str { isRotation = true }
            return temp
        }
        return isRotation
    }
}

class Challenge_08: XCTestCase {

    func test01() {
        XCTAssertTrue("abcde".isRotation(of: "eabcd"))
        XCTAssertTrue("abcde".isRotation("eabcd"))
    }

    func test02() {
        XCTAssertTrue("abcde".isRotation(of: "cdeab"))
        XCTAssertTrue("abcde".isRotation("cdeab"))
    }

    func test03() {
        XCTAssertFalse("abcde".isRotation(of: "abced"))
        XCTAssertFalse("abcde".isRotation("abced"))
    }

    func test04() {
        XCTAssertFalse("abcde".isRotation(of: "a"))
        XCTAssertFalse("abcde".isRotation("a"))
    }
}
