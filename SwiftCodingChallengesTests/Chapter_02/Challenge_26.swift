//
//  Challenge_26.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/24/18.
//

import XCTest

/// Create a function that subtracts one positive integer from another, without using -.

private func sub(x: Int, y: Int) -> Int {
    return y + (-x)
}

private func sub2(x: Int, y: Int) -> Int {
    return y + (-1 * x)
}

private func sub3(x: Int, y: Int) -> Int {
    return y + (~x + 1)
}

private func msb(x: Int) -> Int {
    var msb = 0.0
    while Int(pow(2.0, msb)) < x {
        msb += 1
    }
    return Int(msb)
}

class Challenge_26: XCTestCase {

    func test01() {
        XCTAssertEqual(sub(x: 5, y: 9), 4)
        XCTAssertEqual(sub(x: 10, y: 30), 20)
        XCTAssertEqual(sub(x: 30, y: 10), -20)
    }

    func test02() {
        XCTAssertEqual(sub2(x: 5, y: 9), 4)
        XCTAssertEqual(sub2(x: 10, y: 30), 20)
        XCTAssertEqual(sub2(x: 30, y: 10), -20)
    }

    func test03() {
        XCTAssertEqual(sub3(x: 5, y: 9), 4)
        XCTAssertEqual(sub3(x: 10, y: 30), 20)
        XCTAssertEqual(sub3(x: 30, y: 10), -20)
    }
}
