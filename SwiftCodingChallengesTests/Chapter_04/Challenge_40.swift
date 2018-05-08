//
//  Challenge_40.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/8/18.
//

import XCTest

/// Create a function that accepts an array of unsorted numbers from 1 to 100 where zero or more numbers might be missing, and returns an array of the missing numbers.

private func missingNumbers(in array: [Int]) -> [Int] {
    let baseline = Set(Array(1...100))
    let input = Set(array)
    let result = baseline.subtracting(input)
    return Array(result).sorted()
}

class Challenge_40: XCTestCase {

    func test01() {
        var testArray = Array(1...100)
        [21,22,34,41].forEach {
            if let index = testArray.index(of: $0) {
                testArray.remove(at: index)
            }

        }

        XCTAssertEqual(missingNumbers(in: testArray), [21,22,34,41])
    }
}

