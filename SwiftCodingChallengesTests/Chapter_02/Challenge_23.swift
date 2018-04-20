//
//  Challenge_23.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/19/18.
//

import XCTest

/// Write a function that accepts a string and returns true if it contains only numbers, i.e. the digits 0 through 9.

extension String {
    func hasDigitsOnly() -> Bool {
        let range = self.range(of: "\\A\\d*\\z", options: .regularExpression, range: nil, locale: nil)
        return range != nil ? true : false
    }

    func hasDigitsOnly2() -> Bool {
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
        return range == nil ? true : false
    }

    func hasDigitsOnly3() -> Bool {
        let range = self.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789").inverted)
        return range == nil ? true : false
    }

}

class Challenge_23: XCTestCase {

    func test01() {
        XCTAssertTrue("01010101".hasDigitsOnly())
        XCTAssertTrue("123456789".hasDigitsOnly())
        XCTAssertTrue("9223372036854775808".hasDigitsOnly())
        XCTAssertFalse("1.01".hasDigitsOnly())
        XCTAssertFalse("101 101".hasDigitsOnly())
        XCTAssertFalse("101*101".hasDigitsOnly())
        XCTAssertTrue("".hasDigitsOnly())

        XCTAssertTrue("01010101".hasDigitsOnly2())
        XCTAssertTrue("123456789".hasDigitsOnly2())
        XCTAssertTrue("9223372036854775808".hasDigitsOnly2())
        XCTAssertFalse("1.01".hasDigitsOnly2())
        XCTAssertFalse("101 101".hasDigitsOnly2())
        XCTAssertFalse("101*101".hasDigitsOnly2())
        XCTAssertTrue("".hasDigitsOnly2())

        XCTAssertTrue("01010101".hasDigitsOnly3())
        XCTAssertTrue("123456789".hasDigitsOnly3())
        XCTAssertTrue("9223372036854775808".hasDigitsOnly3())
        XCTAssertFalse("1.01".hasDigitsOnly3())
        XCTAssertFalse("101 101".hasDigitsOnly3())
        XCTAssertFalse("101*101".hasDigitsOnly3())
        XCTAssertTrue("".hasDigitsOnly3())

    }

}
