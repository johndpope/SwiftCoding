//
//  Challenge_04.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/4/18.
//

import XCTest

/// Write your own version of the contains() method on String that ignores letter case, and without using the existing contains() method.

private extension String {
    func containsString(_ str: String) -> Bool {
        return range(of: str, options: .caseInsensitive, range: nil, locale: nil) != nil
    }
}

class Challenge_04: XCTestCase {

    func test01() {
        XCTAssertTrue("Hello World".containsString("Hello"))
    }

    func test02() {
        XCTAssertTrue("Hello World".containsString("WORLD"))
    }

    func test03() {
        XCTAssertFalse("Hello World".containsString("Goodbye"))
    }
}
