//
//  Challenge_17.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/15/18.
//

import XCTest

/// Write a function that accepts positive minimum and maximum integers, and returns a random number between those two bounds, inclusive.

func random(min: Int, max: Int) -> Int {
    let range = UInt32(Swift.max(max - min, 0))
    let random = arc4random_uniform(range + 1)
    return min + Int(random)
}

class Chapter_17: XCTestCase {

    func test01() {
        let number = random(min: 1, max: 5)
        XCTAssertTrue(1 <= number && number <= 5)
    }

    func test02() {
        let number = random(min: 1, max: 1)
        XCTAssertTrue(1 <= number && number <= 1)
    }

    func test03() {
        let number = random(min: 0, max: 1)
        XCTAssertTrue(0 <= number && number <= 1)
    }
}
