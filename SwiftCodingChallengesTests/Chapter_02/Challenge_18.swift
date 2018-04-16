//
//  Challenge_18.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/15/18.
//

import XCTest

func pow(base: Double, exponent: Double) -> Double {
    guard exponent != 0 else { return 1  }
    guard base != 0 else { return exponent >= 0 ? 0 : Double.infinity }
    if exponent > 0 {
        return base * pow(base, exponent - 1.0)
    } else {
        return 1.0 / (base * pow(base, exponent - 1.0))
    }
}

class Challenge_18: XCTestCase {

    func test01() {
        XCTAssertEqual(pow(0, 0), pow(base: 0, exponent: 0))
        XCTAssertEqual(pow(0, 100), pow(base: 0, exponent: 100))
        XCTAssertEqual(pow(0, -100), pow(base: 0, exponent: -100))
        XCTAssertEqual(pow(1, 0), pow(base: 1, exponent: 0))
        XCTAssertEqual(pow(-1, 0), pow(base: -1, exponent: 0))
        XCTAssertEqual(pow(100, 0), pow(base: 100, exponent: 0))
        XCTAssertEqual(pow(-100, 0), pow(base: -100, exponent: 0))
        XCTAssertEqual(pow(1, 1), pow(base: 1, exponent: 1))
        XCTAssertEqual(pow(100, 1), pow(base: 100, exponent: 1))
        XCTAssertEqual(pow(-100, 1), pow(base: -100, exponent: 1))
        XCTAssertEqual(pow(2, 8), pow(base: 2, exponent: 8))
        XCTAssertEqual(pow(-2, 8), pow(base: -2, exponent: 8))
    }
}
