//
//  Challenge_25.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/21/18.
//

import XCTest

/// Write a function that returns the square root of a positive integer, rounded down to the nearest integer, without using sqrt().

fileprivate func sqrRoot(_ x: Int) -> Int {

    var remainder = 0
    var result = 0

    for tuple in tuples(of: x, elements: 2) {
        let x = (remainder * 100) + tuple
        let y = largestMultiplier(target: x, accumulator: result)
        remainder = x - y.result
        result = (result * 10) + y.multiplier % 10
    }

    return result
}

fileprivate func tuples(of x: Int, elements: Int) -> [Int] {
    let modulo = Int(pow(base: 10.0, exponent: Double(elements)))
    var temp = x
    var result = [Int]()

    while temp > 0 {
        let tuple = temp % modulo
        result.insert(tuple, at: 0)
        temp = temp / modulo
    }
    return result
}

fileprivate func largestMultiplier(target: Int, accumulator: Int) -> (multiplier: Int, result: Int) {
    let tempMultiplier = accumulator * 2 * 10
    var multiplier = 0
    var result = 0

    for i in 0...9 {
        let test = (tempMultiplier + (i + 1)) * (i + 1)
        if test > target {
            multiplier = tempMultiplier + i
            result = (tempMultiplier + i) * i
            break
        }
    }
    return (multiplier: multiplier, result: result)

}

func sqrRoot2(_ x: Int) -> Int {
    guard x != 1 else { return 1 }
    let limit = (x / 2) + 1
    for i in 0 ... limit {
        if i * i > x {
            return i - 1
        }
    }
    return 0
}

func sqrRoot3(_ x: Int) -> Int {
    guard x != 1 else { return 1 }

    var lowerBound = 0
    var upperBound = (x / 2) + 1
    var midBound = 0

    while lowerBound + 1 < upperBound {
        midBound = lowerBound + ((upperBound - lowerBound) / 2)
        let square = midBound * midBound

        if square < x {
            lowerBound = midBound
        } else if square > x {
            upperBound = midBound
        } else {
            return midBound
        }
    }
    return lowerBound
}

class Challenge_25: XCTestCase {

    func testTuples() {
        XCTAssertEqual(tuples(of: 123, elements: 2), [1,23])
        XCTAssertEqual(tuples(of: 12, elements: 2), [12])
        XCTAssertEqual(tuples(of: 1234, elements: 2), [12,34])
        XCTAssertEqual(tuples(of: 0, elements: 2), [])
    }

    func testLargestMultiplier() {
        let res1 = largestMultiplier(target: 4, accumulator: 0)
        XCTAssertEqual(res1.multiplier, 2)
        XCTAssertEqual(res1.result, 4)

        let res2 = largestMultiplier(target: 380, accumulator: 2)
        XCTAssertEqual(res2.multiplier, 47)
        XCTAssertEqual(res2.result, 329)

        let res3 = largestMultiplier(target: 5114, accumulator: 27)
        XCTAssertEqual(res3.multiplier, 549)
        XCTAssertEqual(res3.result, 4941)
    }

    func test01() {
        XCTAssertEqual(sqrRoot(16777216),4096)
        XCTAssertEqual(sqrRoot(16), 4)
        XCTAssertEqual(sqrRoot(15), 3)
        XCTAssertEqual(sqrRoot(780), 27)
        XCTAssertEqual(sqrRoot(0), 0)
        XCTAssertEqual(sqrRoot(1), 1)
    }

    func test02() {
        XCTAssertEqual(sqrRoot2(16777216),4096)
        XCTAssertEqual(sqrRoot2(16), 4)
        XCTAssertEqual(sqrRoot2(15), 3)
        XCTAssertEqual(sqrRoot2(780), 27)
        XCTAssertEqual(sqrRoot2(0), 0)
        XCTAssertEqual(sqrRoot2(1), 1)
    }

    func test03() {
        XCTAssertEqual(sqrRoot3(0), 0)
        XCTAssertEqual(sqrRoot3(1), 1)
        XCTAssertEqual(sqrRoot3(4), 2)
        XCTAssertEqual(sqrRoot3(15), 3)
        XCTAssertEqual(sqrRoot3(16), 4)
        XCTAssertEqual(sqrRoot3(780), 27)
        XCTAssertEqual(sqrRoot3(16777216),4096)
    }
}
