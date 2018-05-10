//
//  Challenge_41.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/9/18.
//

import XCTest

/// Write an extension to collections that accepts an array of Int and returns the median average, or nil if there are no values.

private extension Collection where Element == Int{

    func median() -> Double? {
        guard !isEmpty else {
            return nil
        }

        let sorted = self.sorted()
        let midIndex = sorted.count / 2
        if (sorted.count % 2 == 0) {
            let midLhs = sorted[midIndex - 1]
            let midRhs = sorted[midIndex]
            return Double(midLhs) + (Double(midRhs - midLhs) / 2.0)
        } else {
            return Double(sorted[midIndex])
        }
    }
}

class Challenge_41: XCTestCase {

    func test01() {
        XCTAssertEqual([1,2,3].median(), 2)
        XCTAssertEqual([1,2,9].median(), 2)
        XCTAssertEqual([1,3,5,7,9].median(), 5)
        XCTAssertEqual([1,2,3,4].median(), 2.5)
        XCTAssertEqual([Int]().median(), nil)
    }
}
