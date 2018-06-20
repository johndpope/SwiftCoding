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

    private func sortedInsert(value: Element, in array: Array) -> Array {
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

    func insertionSort2() -> Array {
        return reduce(Array(), { (result, value) -> Array in
            let (rhs, lhs) = split(array: result, value: value)
            return rhs + [value] + lhs
        })
    }

    private func split(array: Array, value: Element) -> (Array, Array) {
        for (index, item) in array.enumerated() {
            if item >= value {
                let lhs = Array(array[array.startIndex..<index])
                let rhs = Array(array[index..<array.endIndex])
                return (lhs, rhs)
            }
        }
        return (array, [])
    }

    func insertionSort3() -> Array {
        return reduce(Array(), { (result, value) -> Array in
            var result = result
            result.swapInsert(value: value)
            print(result)
            return result
        })
    }

    mutating func swapInsert(value: Element) {
        insert(value, at: 0)
        let lower = startIndex + 1
        let upper = endIndex

        (lower ..< upper).forEach { index in
            let item = self[index]
            if item < value {
                swapAt(index - 1, index)
            } else {
                return
            }
        }
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

    func test2() {
        XCTAssertEqual([Int]().insertionSort2(), [])
        XCTAssertEqual([10].insertionSort2(), [10])
        XCTAssertEqual([12,5,4,9,3,2,1].insertionSort2(), [1,2,3,4,5,9,12])
        XCTAssertEqual(["f", "a", "b"].insertionSort2(), ["a", "b", "f"])
        XCTAssertEqual([1,2,3].insertionSort2(), [1,2,3])
    }

    func test3() {
        XCTAssertEqual([Int]().insertionSort3(), [])
        XCTAssertEqual([10].insertionSort3(), [10])
        XCTAssertEqual([12,5,4,9,3,2,1].insertionSort3(), [1,2,3,4,5,9,12])
        XCTAssertEqual(["f", "a", "b"].insertionSort3(), ["a", "b", "f"])
        XCTAssertEqual([1,2,3].insertionSort3(), [1,2,3])
    }
}
