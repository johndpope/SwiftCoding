//
//  Challenge_49.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/18/18.
//

import XCTest

/// Write a function that accepts a variadic array of integers and return the sum of all numbers that appear an even number of times.

private func sumEvenRepeats(input: Int...) -> Int {
    var sortedInput = input.sorted()
    guard let first = sortedInput.first else {
        return 0
    }

    sortedInput.removeFirst()

    typealias Output = (sum: Int, previous: Int, count: Int)

    let initialData = (sum: 0, previous: first, count: 1)
    var output = sortedInput.reduce(initialData) { (result, element) -> Output in
        if result.previous != element{
            if result.count % 2 == 0 {
                return (sum: result.sum + result.previous,
                        previous: element,
                        count: 1)
            } else {
                return (sum: result.sum,
                        previous: element,
                        count: 1)
            }
        } else {
            return (sum: result.sum,
                    previous: element,
                    count: result.count + 1)
        }
    }

    output = output.count % 2 == 0 ? (sum: output.sum + output.previous, previous: 0, count: 0) : output

    return output.sum
}

class Challenge_49: XCTestCase {

    func test01() {
        XCTAssertEqual(sumEvenRepeats(input: 1, 2, 2, 3, 3, 4), 5)
        XCTAssertEqual(sumEvenRepeats(input: 5, 5, 5, 12, 12), 12)
        XCTAssertEqual(sumEvenRepeats(input: 1, 1, 2, 2, 3, 3, 4, 4), 10)
    }
}
