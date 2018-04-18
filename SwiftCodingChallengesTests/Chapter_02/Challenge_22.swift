//
//  Challenge_22.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/18/18.
//

import XCTest

/// Create a function that accepts an unsigned 8-bit integer and returns its binary reverse, padded so that it holds precisely eight binary digits.

/// Tip: When you get the binary representation of a number, Swift will always use as few bits as possible – make sure you pad to eight binary digits before reversing.

func binaryReverse(x: UInt8) -> UInt8 {
    var temp = ""
    for index in (0..<x.bitWidth) {
        temp += (x & (1 << index) > 0) ? "1" : "0"
    }
    return UInt8(temp, radix: 2) ?? 0
}

func binaryReverse2(x: UInt8) -> UInt8 {
    let binary = String(x, radix: 2)
    let paddingAmount = x.bitWidth - binary.count
    let paddedBinary = String(repeating: "0", count: paddingAmount) + binary
    let reversedBinary = String(paddedBinary.reversed())
    return UInt8(reversedBinary, radix: 2) ?? 0
}

func binaryReverse3(x: UInt8) -> UInt8 {
    let indexes = zip(0..<x.bitWidth, (0..<x.bitWidth).reversed())

    var result = 0
    for (index, reversedIndex) in indexes {
        if (x & (1 << index)) > 0 {
            result += Int(pow(2.0, Double(reversedIndex)))
        }
    }
    return UInt8(result)
}

class Challenge_22: XCTestCase {

    func test01() {
        XCTAssertEqual(binaryReverse(x: 32), 4)
        XCTAssertEqual(binaryReverse(x: 41), 148)
        XCTAssertEqual(binaryReverse(x: 4), 32)
        XCTAssertEqual(binaryReverse(x: 148), 41)

        XCTAssertEqual(binaryReverse2(x: 32), 4)
        XCTAssertEqual(binaryReverse2(x: 41), 148)
        XCTAssertEqual(binaryReverse2(x: 4), 32)
        XCTAssertEqual(binaryReverse2(x: 148), 41)

        XCTAssertEqual(binaryReverse3(x: 32), 4)
        XCTAssertEqual(binaryReverse3(x: 41), 148)
        XCTAssertEqual(binaryReverse3(x: 4), 32)
        XCTAssertEqual(binaryReverse3(x: 148), 41)
    }
}
