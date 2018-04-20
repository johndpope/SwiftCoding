//
//  Challenge_24.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/20/18.
//

import XCTest

/// Given a string that contains both letters and numbers, write a function that pulls out all the numbers then returns their sum.

extension String {
    func add() -> Int {
        var numbers = [Int]()
        var searchRange = self.startIndex..<self.endIndex
        while let range = self.range(of: "\\d+",
                                      options: .regularExpression,
                                      range: searchRange, locale: nil) {
                let subString = self[range]
                numbers.append(Int(subString) ?? 0)
                searchRange = range.upperBound..<self.endIndex
        }
        return numbers.reduce(0, +)
    }

    func add2() -> Int {
        var currentNumber = ""
        var sum = 0

        for letter in self {
            let str = String(letter)

            if Int(str) != nil {
                currentNumber += str
            } else {
                sum += Int(currentNumber) ?? 0
                currentNumber = ""
            }
        }

        sum += Int(currentNumber) ?? 0
        return sum
    }
}

class Challenge_24: XCTestCase {

    func test01() {
        XCTAssertEqual("a1b2c3".add(), 6)
        XCTAssertEqual("a10b20c30".add(), 60)
        XCTAssertEqual("h8ers".add(), 8)
        XCTAssertEqual("1a2b3c".add(), 6)
        XCTAssertEqual("1a 2b 30c".add(), 33)
        XCTAssertEqual("1230".add(), 1230)
        XCTAssertEqual("".add(), 0)
        XCTAssertEqual("1".add(), 1)
        XCTAssertEqual(" 21".add(), 21)

        XCTAssertEqual("a1b2c3".add2(), 6)
        XCTAssertEqual("a10b20c30".add2(), 60)
        XCTAssertEqual("h8ers".add2(), 8)
        XCTAssertEqual("1a2b3c".add2(), 6)
        XCTAssertEqual("1a 2b 30c".add2(), 33)
        XCTAssertEqual("1230".add2(), 1230)
        XCTAssertEqual("".add2(), 0)
        XCTAssertEqual("1".add2(), 1)
        XCTAssertEqual(" 21".add2(), 21)
    }
}
