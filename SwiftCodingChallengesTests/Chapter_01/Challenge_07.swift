//
//  Challenge_07.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/5/18.
//

import XCTest

/// Write a function that returns a string with any consecutive spaces replaced with a single space.

private extension String {

    func condenseSpaces() -> String {
        let temp = self.replacingOccurrences(of: "  ", with: " ")
        if temp.count == self.count {
            return self
        } else {
            return temp.condenseSpaces()
        }
    }

    func condense() -> String {
        var shouldRemoveSpace = false
        return self.filter {
            if $0 == " " && !shouldRemoveSpace {
                shouldRemoveSpace = true
                return true
            } else if $0 == " " && shouldRemoveSpace {
                return false
            } else {
                shouldRemoveSpace = false
                return true
            }
        }
    }
}

class Challenge_07: XCTestCase {

    func test01() {
        XCTAssertEqual("a   b   c".condenseSpaces(), "a b c")
        XCTAssertEqual("a   b   c".condense(), "a b c")
    }

    func test02() {
        XCTAssertEqual("    a".condenseSpaces(), " a")
        XCTAssertEqual("    a".condense(), " a")
    }

    func test03() {
        XCTAssertEqual("abc".condenseSpaces(), "abc")
        XCTAssertEqual("abc".condense(), "abc")
    }
}
