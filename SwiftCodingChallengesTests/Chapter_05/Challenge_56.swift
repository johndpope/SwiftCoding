//
//  Challenge_56.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/19/18.
//

import XCTest

// Create an extension for arrays that sorts them using the insertion sort algorithm.

private extension Array where Element: Comparable {

    func insertionSort() -> Array {
        return reduce(Array(), { (result, element) -> Array in
            sortedInsert(value: element, in: result)
        })
    }

    func sortedInsert(value: Element, in array: Array) -> Array {
        var array = array
        var insertIndex = array.endIndex - 1
        while insertIndex >= 0 {
            let element = array[insertIndex]
            if element <= value {
                break
            }
            insertIndex -= 1
        }

        if insertIndex == (array.endIndex - 1) {
            array.append(value)
        } else {
            array.insert(value, at: insertIndex + 1)
        }

        return array
    }
 }

class Challenge_56: XCTestCase {

    func test() {
        XCTAssertEqual([Int]().insertionSort(), [])
        XCTAssertEqual([10].insertionSort(), [10])
        XCTAssertEqual([12,5,4,9,3,2,1].insertionSort(), [1,2,3,4,5,9,12])
        XCTAssertEqual(["f", "a", "b"].insertionSort(), ["a", "b", "f"])
        XCTAssertEqual([1,2,3].insertionSort(), [1,2,3])
    }

}
