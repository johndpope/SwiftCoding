//
//  Challenge_20.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/16/18.
//

import XCTest

/// Write a function that accepts an integer as its parameter and returns true if the number is prime.

/// Tip: A number is considered prime if it is greater than one and has no positive divisors other than 1 and itself.”


func isPrime01(_ x: Int) -> Bool {
    guard x > 1 else { return false }

    var dividend = 1
    repeat {
        dividend += 1
        if x % dividend == 0 { break }
    } while dividend <= x

    return x == dividend
}

func isPrime02(_ x: Int) -> Bool {
    guard x >= 2 else { return false }
    guard x != 2 else { return true }

    let lowerLimit = Int(ceil(sqrt(Double(x))))

    var dividend = 2
    while dividend <= lowerLimit {
        if x % dividend == 0 { return false }
        dividend += 1
    }

    return true
}

class Challenge_20: XCTestCase {

    func test01() {
        XCTAssertFalse(isPrime01(-1))
        XCTAssertFalse(isPrime01(0))
        XCTAssertFalse(isPrime01(1))
        XCTAssertTrue(isPrime01(2))
        XCTAssertTrue(isPrime01(3))
        XCTAssertFalse(isPrime01(4))
        XCTAssertTrue(isPrime01(5))
        XCTAssertFalse(isPrime01(6))
        XCTAssertTrue(isPrime01(7))
        XCTAssertFalse(isPrime01(8))
        XCTAssertFalse(isPrime01(9))
        XCTAssertFalse(isPrime01(10))
        XCTAssertTrue(isPrime01(11))
        XCTAssertTrue(isPrime01(307))
        XCTAssertTrue(isPrime01(349))
        XCTAssertFalse(isPrime01(350))
        XCTAssertTrue(isPrime01(997))
        XCTAssertFalse(isPrime01(6398))
        XCTAssertTrue(isPrime01(16777259))
    }

    func test02() {
        XCTAssertFalse(isPrime02(-1))
        XCTAssertFalse(isPrime02(0))
        XCTAssertFalse(isPrime02(1))
        XCTAssertTrue(isPrime02(2))
        XCTAssertTrue(isPrime02(3))
        XCTAssertFalse(isPrime02(4))
        XCTAssertTrue(isPrime02(5))
        XCTAssertFalse(isPrime02(6))
        XCTAssertTrue(isPrime02(7))
        XCTAssertFalse(isPrime02(8))
        XCTAssertFalse(isPrime02(9))
        XCTAssertFalse(isPrime02(10))
        XCTAssertTrue(isPrime02(11))
        XCTAssertTrue(isPrime02(307))
        XCTAssertTrue(isPrime02(349))
        XCTAssertFalse(isPrime02(350))
        XCTAssertTrue(isPrime02(997))
        XCTAssertFalse(isPrime02(6398))
        XCTAssertTrue(isPrime02(16777259))
    }

    func testP01() {
        measure {
            isPrime01(16777259)
        }
    }

    func testP02() {
        measure {
            isPrime02(16777259)
        }
    }
}
