//
//  Challenge_59.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/25/18.
//

import XCTest

private extension Array where Element: Comparable {

    func quickSort() -> Array {
        var copy = self
        return copy.quickSort(start: startIndex, end: endIndex)
    }

    private mutating func quickSort(start: Int, end: Int) -> Array {
        guard start >= startIndex,
            end <= endIndex else {
                fatalError()
        }

        guard end > start else {
            return self
        }

        var pivotIndex = (end - 1)
        let pivot = self[pivotIndex]
        var runner = start

        while runner < end {
            let value = self[runner]
            if value <= pivot {
                if runner < pivotIndex {
                } else {
                    swapAt(runner, pivotIndex)
                    pivotIndex = runner
                }
            } else {
                if runner < pivotIndex {
                    swapAt(runner, pivotIndex)
                    pivotIndex = runner
                } else {
                }
            }
            runner += 1
        }

        _ = quickSort(start: start, end: pivotIndex)
        _ = quickSort(start: pivotIndex+1, end: end)
        return self
    }
}

class Challenge_59: XCTestCase {
    func test() {
        XCTAssertEqual([Int]().quickSort(), [])
        XCTAssertEqual([10].quickSort(), [10])
        XCTAssertEqual([1,2,3].quickSort(), [1,2,3])
        XCTAssertEqual([12,5,4,9,3,2,1].quickSort(), [1,2,3,4,5,9,12])
        XCTAssertEqual(["f", "a", "b"].quickSort(), ["a", "b", "f"])
    }

}
