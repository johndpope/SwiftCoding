//
//  Challenge_21.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/17/18.
//

import XCTest

/// Create a function that accepts any positive integer and returns the next highest and next lowest number that has the same number of ones in its binary representation. If either number is not possible, return nil for it.

func challenge21(x: Int) -> (nextHighest: Int?, nextLowest: Int?) {

    var (highest, lowest): (Int?, Int?) = (nil, nil)
    let ones = numberOfOnes(in: x)

    var temp = x
    repeat {
        temp += 1
        if numberOfOnes(in: temp) == ones {
            highest = temp
            break
        }
    } while temp < UInt.max

    temp = x
    repeat {
        temp -= 1
        if numberOfOnes(in: temp) == ones {
            lowest = temp
            break
        }
    } while temp > 0

    return (highest, lowest)
}

func numberOfOnes(in number: Int) -> Int {
    var counter = 0
    var position = 0
    while true {
        let matcher = 1 << position

        guard matcher < number else {
            return counter
        }

        if number & matcher > 0 {
            counter += 1
        }

        position += 1
    }
}

func challenge21b(x: Int) -> (nextHighest: Int?, nextLowest: Int?) {
    let ones = oneCount(in: x)

    return (sameNumberOfOnes(x: x, ones: ones, op: +),
            sameNumberOfOnes(x: x, ones: ones, op: -))
}

func oneCount(in x: Int) -> Int {
    let strX = String(x, radix: 2, uppercase: false)
    return strX.filter { $0 == "1" }.count
}

func sameNumberOfOnes(x: Int, ones: Int, op: (Int, Int) -> Int) -> Int? {
    var target: Int? = nil
    var temp = x
    while x < Int.max && x > 0 {
        temp = op(temp, 1)
        if oneCount(in: temp) == ones {
            target = temp
            break
        }
    }

    return target
}

class Challenge_21: XCTestCase {

    func test01() {
        let (highest, lowest) = challenge21(x: 12)
        XCTAssertEqual(highest, 17)
        XCTAssertEqual(lowest, 10)
    }

    func test02() {
        let (highest, lowest) = challenge21(x: 28)
        XCTAssertEqual(highest, 35)
        XCTAssertEqual(lowest, 26)
    }

    func test03() {
        let (highest, lowest) = challenge21b(x: 12)
        XCTAssertEqual(highest, 17)
        XCTAssertEqual(lowest, 10)
    }

    func test04() {
        let (highest, lowest) = challenge21b(x: 28)
        XCTAssertEqual(highest, 35)
        XCTAssertEqual(lowest, 26)
    }

}
