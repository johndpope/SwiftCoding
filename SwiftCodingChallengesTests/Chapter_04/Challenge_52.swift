//
//  Challenge_52.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/12/18.
//

import XCTest

// Write one function that sums an array of numbers. The array might contain all integers, all doubles, or all floats.

private func sum<T: Numeric>(numbers: [T]) -> T {
    return numbers.reduce(0, +)
}

class Challenge_52: XCTestCase {

    func test01() {
        XCTAssertEqual(sum(numbers: [1,2,3]), 6)
        XCTAssertEqual(sum(numbers: [1.0,2.0,3.0]), 6.0)
        XCTAssertEqual(sum(numbers: Array<Float>([1.0,2.0,3.0])), 6.0)
    }
}
