//
//  Challenge_61.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/27/18.
//

import XCTest

// Write a function that returns an array of prime numbers from 2 up to but excluding N, taking care to be as efficient as possible.

private func findPrimes(limit: Int) -> [Int] {
    guard limit > 1 else {
        return [Int]()
    }

    var filteredNumbers = Array(2..<limit)
    var numberIndex = filteredNumbers.startIndex

    while numberIndex < filteredNumbers.endIndex {
        let factor = filteredNumbers[numberIndex]
        filteredNumbers = filteredNumbers.filter {
            guard factor != $0 else { return true }
            return ($0 % factor) != 0
        }
        numberIndex += 1
    }

    return filteredNumbers
}

class Challenge_61: XCTestCase {

    func testFindPrimes() {
        XCTAssertEqual(findPrimes(limit: 10), [2,3,5,7])
        XCTAssertEqual(findPrimes(limit: 11), [2,3,5,7])
        XCTAssertEqual(findPrimes(limit: 12), [2,3,5,7,11])
        XCTAssertEqual(findPrimes(limit: 110), [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109])
    }
}
