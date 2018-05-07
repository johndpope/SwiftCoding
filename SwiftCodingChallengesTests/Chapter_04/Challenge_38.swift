//
//  Challenge_38.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/7/18.
//

import XCTest

/// Write an extension for all collections that returns the N smallest elements as an array, sorted smallest first, where N is an integer parameter.

private extension Collection where Element: Comparable {

    func smallest(count: Int) -> [Element] {
        return Array(self.sorted().prefix(count))
    }
}

class Challenge_38: XCTestCase {

    func test01() {
        XCTAssertEqual([1,2,3,4].smallest(count: 3), [1,2,3])
        XCTAssertEqual(["q", "f", "k"].smallest(count: 3), ["f", "k", "q"])
        XCTAssertEqual([256, 16].smallest(count: 3), [16, 256])
        XCTAssertEqual([String]().smallest(count: 3), [])
    }

}
