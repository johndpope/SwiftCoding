//
//  Challenge_19.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/16/18.
//

import XCTest

/// Swap two positive variable integers, a and b, without using a temporary variable.

func swap01(_ a: Int, _ b: Int) -> (b: Int, a: Int) {
    return (b, a)
}

func swap02(_ a: Int, _ b: Int) -> (b: Int, a: Int) {
    var a = a
    var b = b

    a = a + b
    b = a - b
    a = a - b

    return (b: a, a: b)
}

func swap03(_ a: Int, _ b: Int) -> (b: Int, a: Int) {
    var a = a
    var b = b

    a = a ^ b
    b = a ^ b
    a = a ^ b

    return (b: a, a: b)
}

class Challenge_19: XCTestCase {

    func test01() {
        let (b, a) = swap01(10, 20)
        XCTAssertTrue(b == 20 && a == 10)
        let (x, y) = swap02(10, 20)
        XCTAssertTrue(x == 20 && y == 10)
        let (i,u) = swap03(10, 20)
        XCTAssertTrue(i == 20 && u == 10)
    }
}
