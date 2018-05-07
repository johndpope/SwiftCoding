//
//  Challenge 37.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/5/18.
//

import XCTest

/// Write an extension for collections of integers that returns the number of times a specific digit appears in any of its numbers.

private func count(of digit: Int, in collection: [Int]) -> Int {

    let count = collection.reduce(0) { (res, value) in
        return res + value.count(of: digit)
    }
    return count
}

private extension Int {

    func count(of digit: Int) -> Int {
        var count = 0
        var dividend = self
        var remainder = 0
        var temp = dividend / 10

        repeat {
            temp = dividend / 10
            remainder = dividend % 10
            if remainder == digit { count += 1 }
            dividend = temp
        } while temp > 0

        return count
    }
}

class Challenge_37: XCTestCase {

    func test01() {
        XCTAssertEqual(count(of: 5, in: [5, 15, 55, 515]), 6)
        XCTAssertEqual(count(of: 1, in: [5, 15, 55, 515]), 2)
        XCTAssertEqual(count(of: 5, in: [55555]), 5)
        XCTAssertEqual(count(of: 1, in: [55555]), 0)
    }

}
