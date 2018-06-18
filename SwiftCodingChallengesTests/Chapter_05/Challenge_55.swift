//
//  Challenge_55.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/16/18.
//

import XCTest

// Create an extension for arrays that sorts them using the bubble sort algorithm.

private extension Array where Element: Comparable {

    func bubbleSort() -> Array {
        guard let firstPair = firstPair else {
            return self
        }

        var result =  self

        var rangeEnd = endIndex

        while startIndex < rangeEnd {
            var pair = firstPair
            while pair.upperBound < endIndex {
                var pairValues = result[pair]
                pairValues.sort()
                result[pair] = pairValues
                pair = advance(pair: pair)
            }
            rangeEnd -= 1
        }

        return result
    }

    var firstPair: CountableClosedRange<Int>? {
        guard endIndex - startIndex >= 2 else {
            return nil
        }
        return (startIndex...startIndex+1)
    }

    func advance(pair: CountableClosedRange<Int>) -> CountableClosedRange<Int> {
        return (pair.upperBound...(pair.upperBound + 1))
    }
}

class Challenge_55: XCTestCase {

    func test() {
        XCTAssertEqual([Int]().bubbleSort(), [])
        XCTAssertEqual([10].bubbleSort(), [10])
        XCTAssertEqual([12,5,4,9,3,2,1].bubbleSort(), [1,2,3,4,5,9,12])
        XCTAssertEqual(["f", "a", "b"].bubbleSort(), ["a", "b", "f"])
        XCTAssertEqual([1,2,3].bubbleSort(), [1,2,3])
    }
}
