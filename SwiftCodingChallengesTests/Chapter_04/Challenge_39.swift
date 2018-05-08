//
//  Challenge_39.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/8/18.
//

import XCTest

/// Extend collections with a function that returns an array of strings sorted by their lengths, longest first.

private extension Collection where Element: CustomStringConvertible{

    func sortedByLength() -> [Element] {
        return sorted { (rhs, lhs) in
            rhs.description.count >  lhs.description.count
        }
    }
}

private extension Collection where Element == String {

    func sortedByLength() -> [Element] {
        return sorted { (rhs, lhs) in
            rhs.description.count >  lhs.description.count
        }
    }
}
class Challenge_39: XCTestCase {

    func test01() {
        XCTAssertEqual(["a", "abc", "ab"].sortedByLength(), ["abc", "ab", "a"])
        XCTAssertEqual(["paul", "taylor", "adele"].sortedByLength(), ["taylor", "adele", "paul"])
        XCTAssertEqual([String]().sortedByLength(), [])
    }
}
