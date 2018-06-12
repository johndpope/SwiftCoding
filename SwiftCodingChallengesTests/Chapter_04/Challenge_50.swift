//
//  Challenge_50.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/22/18.
//

import XCTest

// Write a function that accepts an array of positive and negative numbers and returns a closed range containing the position of the contiguous positive numbers that sum to the highest value, or nil if nothing were found.

private func rangeOfMaxSum(in values: Int...) -> ClosedRange<Int>? {

    typealias RangeSum = (start: Int, end: Int, sum: Int)
    typealias RangeSumValues = (ranges: [RangeSum], currentRange: RangeSum?)

    let emptyRangeValues = RangeSumValues(ranges: [], currentRange: nil)
    var rangeValues = values.enumerated().reduce(emptyRangeValues) { (temp, value) -> RangeSumValues in
        if value.element <= 0 {
            if let currentRange = temp.currentRange {
                var updatedRanges = temp.ranges
                updatedRanges.append(currentRange)
                return RangeSumValues(ranges: updatedRanges, currentRange: nil)
            } else {
                return temp
            }
        } else {
            if let currentRange = temp.currentRange {
                let updatedRange = RangeSum(start: currentRange.start, end: value.offset, sum: value.element + currentRange.sum)
                return RangeSumValues(ranges: temp.ranges, currentRange: updatedRange)
            } else {
                let newRange = RangeSum(start: value.offset, end: value.offset, sum: value.element)
                return RangeSumValues(ranges: temp.ranges, currentRange: newRange)
            }
        }
    }

    if let currentRange = rangeValues.currentRange {
        var updatedRanges = rangeValues.ranges
        updatedRanges.append(currentRange)
        rangeValues = RangeSumValues(ranges: updatedRanges, currentRange: nil)
    }

    let sortedRanges = rangeValues.ranges.sorted { (lhs, rhs) -> Bool in
        return lhs.sum > rhs.sum
    }

    guard let firstRange = sortedRanges.first else {
        return nil
    }
    return firstRange.start ... firstRange.end
}

class Challenge_50: XCTestCase {

    func test01() {
        XCTAssertEqual(rangeOfMaxSum(in: 0, 1, 1, -1, 2, 3, 1), 4...6)
        XCTAssertEqual(rangeOfMaxSum(in: 10, 20, 30, -10, -20, 10, 20), 0...2)
        XCTAssertEqual(rangeOfMaxSum(in: 1, -1, 2, -1), 2...2)
        XCTAssertEqual(rangeOfMaxSum(in: 2, 0, 2, 0, 2), 0...0)
        XCTAssertEqual(rangeOfMaxSum(in: 0), nil)
    }
}
