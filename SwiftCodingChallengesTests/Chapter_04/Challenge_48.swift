//
//  Challenge_48.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/18/18.
//

import XCTest

// Create a new data type that models a double-ended queue using generics, or deque. You should be able to push items to the front or back, pop them from the front or back, and get the number of items.

private struct Deque<T> {

    private var store: Array<T>

    init() {
        store = Array<T>()
    }

    var count: Int {
        return store.count
    }

    mutating func pushFront(_ element: T) {
        store.insert(element, at: 0)
    }

    mutating func pushBack(_ element: T) {
        store.append(element)
    }

    mutating func popFront() -> T? {
        guard !store.isEmpty else {
            return nil
        }

        return store.remove(at: 0)
    }

    mutating func popBack() -> T? {
        guard !store.isEmpty else {
            return nil
        }
        return store.removeLast()
    }
}

class Challenge_48: XCTestCase {

    func test01() {
        var numbers = Deque<Int>()
        numbers.pushBack(5)
        numbers.pushBack(8)
        numbers.pushBack(3)

        XCTAssertEqual(numbers.count, 3)
        XCTAssertEqual(numbers.popFront(), 5)
        XCTAssertEqual(numbers.popBack(), 3)
        XCTAssertEqual(numbers.popFront(), 8)
        XCTAssertNil(numbers.popBack())
        XCTAssertNil(numbers.popFront())
    }

}
